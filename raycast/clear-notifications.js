#!/usr/bin/osascript -l JavaScript

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Clear Notifications
// @raycast.mode silent
// @raycast.packageName Utilities
// @raycast.description Clear Notification Center banners and alerts

let remainingTries = 5

while (true) {
  try {
    Application("System Events")
      .applicationProcesses.byName("NotificationCenter")
      .windows[0]
      .entireContents()
      .find(item => item.subrole()?.startsWith("AXNotificationCenter"))
      .actions()
      .slice(-1)[0]
      .perform()
  } catch {
    remainingTries--
    if (remainingTries < 1) break
  }
}
