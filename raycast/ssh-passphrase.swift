import Foundation

func fail(_ message: String) -> Never {
    // Never include CLI output or secrets in errors shown by Raycast.
    fputs(message + "\n", stderr)
    exit(1)
}

let cacheScpt = FileManager.default.homeDirectoryForCurrentUser
    .appendingPathComponent(".cache/ssh-passphrase/iterm.scpt")
let scptPath = ProcessInfo.processInfo.environment["SSH_PASSPHRASE_SCPT"] ?? cacheScpt.path
var loadError: NSDictionary?
guard let script = NSAppleScript(contentsOf: URL(fileURLWithPath: scptPath), error: &loadError) else {
    fail("Could not load iTerm2 automation. Rebuild the command cache and retry.")
}
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
        fail("iTerm2 automation failed or the session changed. Check Automation permissions and retry at the SSH or sudo prompt.")
    }
    return result
}

enum PromptKind {
    case sshKey
    case sudo
}

func promptKind(from prompt: String) -> PromptKind? {
    if prompt.hasPrefix("Enter passphrase for key "), prompt.hasSuffix(":") {
        return .sshKey
    }
    if prompt.hasPrefix("[sudo] password for "), prompt.hasSuffix(":") {
        return .sudo
    }
    if prompt == "Password:" {
        return .sudo
    }
    return nil
}

let arguments = Array(CommandLine.arguments.dropFirst())
guard arguments.count == 1, ["1", "2"].contains(arguments[0]) else {
    fail("Select Key 1 or Key 2 (argument: 1 or 2).")
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
guard let kind = promptKind(from: prompt) else {
    fail("iTerm2 must be waiting at an OpenSSH key-passphrase or sudo password prompt.")
}
// Keep the original reference.txt as Key 1 for existing installations.
let filename: String
switch (arguments[0], kind) {
case ("1", .sshKey): filename = "reference.txt"
case ("2", .sshKey): filename = "reference2.txt"
case ("1", .sudo): filename = "sudo.txt"
case ("2", .sudo): filename = "sudo2.txt"
default: fail("Select Key 1 or Key 2 (argument: 1 or 2).")
}
let config = FileManager.default.homeDirectoryForCurrentUser
    .appendingPathComponent(".config/ssh-passphrase/" + filename)
let reference = ((try? String(contentsOf: config, encoding: .utf8)) ?? "")
    .trimmingCharacters(in: .whitespacesAndNewlines)
guard reference.hasPrefix("op://"),
      !reference.unicodeScalars.contains(where: { CharacterSet.controlCharacters.contains($0) }) else {
    fail("Set an op:// reference in ~/.config/ssh-passphrase/" + filename + ".")
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
switch kind {
case .sshKey:
    print("Passphrase entered in iTerm2. Press Enter there to submit.")
case .sudo:
    print("Password entered in iTerm2. Press Enter there to submit.")
}
