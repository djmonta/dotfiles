-- Secrets are passed as Apple-event parameters, never interpolated into source.
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
