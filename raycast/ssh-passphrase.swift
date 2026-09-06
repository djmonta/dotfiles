#!/usr/bin/swift
// @raycast.schemaVersion 1
// @raycast.title Type SSH Passphrase in iTerm2
// @raycast.mode compact
// @raycast.icon 🔐
// @raycast.argument1 {"type":"dropdown","placeholder":"Passphrase","data":[{"title":"mw_user","value":"1"},{"title":"miyamoto","value":"2"}]}
// @raycast.description Type a 1Password passphrase into the unchanged iTerm2 SSH prompt.

import AppKit
import Foundation

func fail(_ message: String) -> Never {
    // Never include CLI output or secrets in errors shown by Raycast.
    fputs(message + "\n", stderr)
    exit(1)
}

// Secrets are passed as Apple-event parameters, never interpolated into source.
let scriptSource = """
on snapshot()
    tell application id "com.googlecode.iterm2"
        if not running then error "iTerm2 is not running"
        if (count of windows) is 0 then error "No window"
        set targetSession to current session of current window
        return {unique ID of targetSession, contents of targetSession}
    end tell
end snapshot

on deliver(expectedID, expectedContents, passphrase)
    tell application id "com.googlecode.iterm2"
        if (count of windows) is 0 then error "No window"
        set targetSession to current session of current window
        if unique ID of targetSession is not expectedID then error "Session changed"
        if contents of targetSession is not expectedContents then error "Screen changed"
        tell targetSession to write text passphrase newline no
    end tell
    return "sent"
end deliver
"""
guard let script = NSAppleScript(source: scriptSource) else { fail("Could not create iTerm2 automation.") }
func callHandler(_ name: String, _ values: [String] = []) -> NSAppleEventDescriptor {
    let event = NSAppleEventDescriptor(eventClass: 0x61736372, eventID: 0x70736272,
        targetDescriptor: nil, returnID: -1, transactionID: 0)
    event.setParam(NSAppleEventDescriptor(string: name), forKeyword: 0x736e616d)
    let parameters = NSAppleEventDescriptor.list()
    for (index, value) in values.enumerated() {
        parameters.insert(NSAppleEventDescriptor(string: value), at: index + 1)
    }
    event.setParam(parameters, forKeyword: 0x2d2d2d2d)
    var error: NSDictionary?
    let result = script.executeAppleEvent(event, error: &error)
    guard error == nil else {
        fail("iTerm2 automation failed or the session changed. Check Automation permissions and retry at the SSH passphrase prompt.")
    }
    return result
}

let arguments = Array(CommandLine.arguments.dropFirst())
guard arguments.count == 1, ["1", "2"].contains(arguments[0]) else {
    fail("Select Key 1 or Key 2 (argument: 1 or 2).")
}
// Keep the original reference.txt as Key 1 for existing installations.
let filename = arguments[0] == "1" ? "reference.txt" : "reference2.txt"
let config = FileManager.default.homeDirectoryForCurrentUser
    .appendingPathComponent(".config/ssh-passphrase/" + filename)
let reference = ((try? String(contentsOf: config, encoding: .utf8)) ?? "")
    .trimmingCharacters(in: .whitespacesAndNewlines)
guard reference.hasPrefix("op://"),
      !reference.unicodeScalars.contains(where: { CharacterSet.controlCharacters.contains($0) }) else {
    fail("Set an op:// reference in ~/.config/ssh-passphrase/" + filename + ".")
}
let candidates = ["/opt/homebrew/bin/op", "/usr/local/bin/op"]
guard let executable = candidates.first(where: { FileManager.default.isExecutableFile(atPath: $0) }) else {
    fail("1Password CLI is missing. Install 1password-cli first.")
}

// Capture before 1Password authentication so tab switches cannot redirect input.
let snapshot = callHandler("snapshot")
guard let sessionID = snapshot.atIndex(1)?.stringValue, !sessionID.isEmpty,
      let screen = snapshot.atIndex(2)?.stringValue else {
    fail("Could not identify the iTerm2 session.")
}
let prompt = screen.components(separatedBy: .newlines)
    .map { $0.trimmingCharacters(in: .whitespaces) }
    .last(where: { !$0.isEmpty }) ?? ""
guard prompt.hasPrefix("Enter passphrase for key "), prompt.hasSuffix(":") else {
    fail("iTerm2 must be waiting at an OpenSSH 'Enter passphrase for key …:' prompt.")
}

let request = Process()
request.executableURL = URL(fileURLWithPath: executable)
request.arguments = ["read", "--no-newline", reference]
request.standardInput = FileHandle.nullDevice
request.standardError = FileHandle.nullDevice
let output = Pipe()
request.standardOutput = output
do { try request.run() } catch { fail("Could not start 1Password CLI.") }
let data = output.fileHandleForReading.readDataToEndOfFile()
request.waitUntilExit()
guard request.terminationStatus == 0 else {
    fail("1Password read failed. Check the reference and CLI app integration, then retry.")
}
guard let secret = String(data: data, encoding: .utf8), !secret.isEmpty,
      !secret.unicodeScalars.contains(where: { CharacterSet.controlCharacters.contains($0) }) else {
    fail("The selected field is empty or is not a single-line passphrase.")
}

_ = callHandler("deliver", [sessionID, screen, secret])
print("Passphrase entered in iTerm2. Press Enter there to submit.")
