#!/bin/bash

trap 'echo Error: $0: stopped' ERR
set -e
set -u

# A system that judge if this script is necessary or not
# {{{
[[ $OSTYPE != darwin* ]] && exit
#}}}

#
# Testing the judgement system
# {{{
if [[ -n ${DEBUG:-} ]]; then echo "$0" && exit 0; fi
#}}}

# Dock {{{1
set_dock_preferences()
{
    # Automatically hide or show the Dock
    defaults write com.apple.dock autohide -bool true

    # Wipe all app icons from the Dock
    defaults write com.apple.dock persistent-apps -array

    # Set the icon size
    defaults write com.apple.dock tilesize -int 55

    # Magnificate the Dock
    defaults write com.apple.dock magnification -bool true

    # Hot corners
    # Possible values:
    #  0: no-op
    #  2: Mission Control
    #  3: Show application windows
    #  4: Desktop
    #  5: Start screen saver
    #  6: Disable screen saver
    #  7: Dashboard
    # 10: Put display to sleep
    # 11: Launchpad
    # 12: Notification Center
    # Top left screen corner → Mission Control
    #defaults write com.apple.dock wvous-tl-corner -int 2
    #defaults write com.apple.dock wvous-tl-modifier -int 0
    # Top right screen corner → Desktop
    defaults write com.apple.dock wvous-tr-corner -int 4
    defaults write com.apple.dock wvous-tr-modifier -int 0
    # Bottom left screen corner → Start screen saver
    defaults write com.apple.dock wvous-bl-corner -int 2
    defaults write com.apple.dock wvous-bl-modifier -int 0
    # Bottom right screen corner → Show application windows
    defaults write com.apple.dock wvous-br-corner -int 3
    defaults write com.apple.dock wvous-br-modifier -int 0

}

# QuickLook {{{1
set_quicklook_preferences()
{
    # Allow you to select and copy string in QuickLook
    defaults write com.apple.finder QLEnableTextSelection -bool yes
}

# Finder {{{1
set_finder_preferences()
{
    # Automatically open a new Finder window when a volume is mounted
    defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
    defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
    defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

    # Set `Desktop` as the default location for new Finder windows
    defaults write com.apple.finder NewWindowTarget -string "PfDe"
    defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

    # Show Status bar in Finder
    defaults write com.apple.finder ShowStatusBar -bool true

    # Show Path bar in Finder
    defaults write com.apple.finder ShowPathbar -bool true

    # Show Tab bar in Finder
    defaults write com.apple.finder ShowTabView -bool true

    # Show the ~/Library directory
    chflags nohidden ~/Library

    # Show the hidden files
    defaults write com.apple.finder AppleShowAllFiles YES
}

# Keyboard {{{1
set_keyboard_preferences()
{
    # keyboards id
    keyboardid=$(ioreg -n IOHIDKeyboard -r | grep -E 'VendorID"|ProductID' | awk '{ print $4 }' | paste -s -d'-\n' -)'-0'

    # [システム環境設定]，[キーボード] の [修飾キー] - [Caps Lock キー] = [^ Control]
    defaults -currentHost delete -g com.apple.keyboard.modifiermapping.${keyboardid}
    defaults -currentHost add -g com.apple.keyboard.modifiermapping.${keyboardid} -array '<dict><key>HIDKeyboardModifierMappingDst</key></dict><integer>2</integer> <key>HIDKeyboardModifierMappingSrc</key><key>0</key>'
    # [システム環境設定]，[キーボード] の [修飾キー] - [^ Control] = [Caps Lock キー]
    defaults -currentHost add -g com.apple.keyboard.modifiermapping.${keyboardid} - array '<dict><key>HIDKeyboardModifierMappingDst</key></dict><integer>0</integer> <key>HIDKeyboardModifierMappingSrc</key><key>2</key>'
}

# Safari.app {{{1
set_safari_preferences()
{
    # Enable the `Develop` menu and the `Web Inspector`
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
    defaults write com.apple.Safari IncludeDevelopMenu -bool true
    defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

    # Enable `Debug` menu
    defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

    # Show the full URL in the address bar (note: this will still hide the scheme)
    defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

    # Add a context menu item for showing the `Web Inspector` in web views
    defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

    # Show Safari's Status Bar
    defaults write com.apple.Safari ShowStatusBar -bool true

    # Don't remember passwords
    defaults write com.apple.Safari AutoFillPasswords -bool false
}

# Terminal.app {{{1
set_terminal_preferences()
{
    # Use a custom theme
    # Use a modified version of the Solarized Dark theme by default in Terminal.app
    TERM_PROFILE='Solarized_Dark';
    TERM_PATH='./etc/init/osx/app/';
    CURRENT_PROFILE="$(defaults read com.apple.terminal 'Default Window Settings')";
    if [ "${CURRENT_PROFILE}" != "${TERM_PROFILE}" ]; then
        open "$TERM_PATH$TERM_PROFILE.terminal"
        defaults write com.apple.Terminal "Default Window Settings" -string "$TERM_PROFILE"
        defaults write com.apple.Terminal "Startup Window Settings" -string "$TERM_PROFILE"
    fi
    defaults import com.apple.Terminal "$HOME/Library/Preferences/com.apple.Terminal.plist"
}

# Spotlight {{{1
set_spotlight_preferences()
{
    # Load new settings before rebuilding the index
    killall mds > /dev/null 2>&1
    # Make sure indexing is enabled for the main volume
    sudo mdutil -i on / > /dev/null
    # Rebuild the index from scratch
    sudo mdutil -E / > /dev/null
}

# Trackpad {{{1
set_trackpad_preferences()
{
    # Enable `Tap to click`
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

    # Map bottom right Trackpad corner to right-click
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
    defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
    defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
}

# Transmission.app {{{1
set_transmission_preferences()
{
    # Don’t prompt for confirmation before downloading
    defaults write org.m0k.transmission DownloadAsk -bool false

    # Use `~/Downloads` to store complete downloads
    defaults write org.m0k.transmission DownloadChoice -string "Constant"
    defaults write org.m0k.transmission DownloadFolder -string "$HOME/Downloads";

    # Use `~/Downloads/torrents` to store incomplete downloads
    defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
    defaults write org.m0k.transmission IncompleteDownloadFolder -string "$HOME/Downloads/torrents"

    # Hide the donate message
    defaults write org.m0k.transmission WarningDonate -bool false

    # Hide the legal disclaimer
    defaults write org.m0k.transmission WarningLegal -bool false
}

# UI/UX {{{1
set_ui_and_ux_preferences()
{
    # Avoid creating `.DS_Store` files on network volumes
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

    # Hide the battery percentage from the menu bar
    defaults write com.apple.menuextra.battery ShowPercent -string "NO"

    # Time options: Display the time with seconds: on - Date options: Show the day of the week: on
    defaults write com.apple.menuextra.clock 'DateFormat' -string 'EEE H:mm'

    # Disable the "Are you sure you want to open this application?" dialog
    defaults write com.apple.LaunchServices LSQuarantine -bool false

    # Disable `Reopen windows when logging back in`
    #defaults write com.apple.loginwindow TALLogoutSavesState 0

    # Automatically quit the printer app once the print jobs are completed
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

    # Save screenshots as PNGs
    defaults write com.apple.screencapture type -string "png"

    # Require password immediately after the computer went into
    # sleep or screen saver mode
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0

    # Expand save panel by default
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

    # Expand print panel by default
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

    # Hide the Time Machine and Volume icons from the menu bar
    for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
        sudo defaults write "${domain}" dontAutoLoad -array \
            "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
            "/System/Library/CoreServices/Menu Extras/Volume.menu"
    done

    # Show Bluetooth icon
    sudo defaults write com.apple.systemuiserver menuExtras -array \
        "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
        "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
        "/System/Library/CoreServices/Menu Extras/Battery.menu" \
        "/System/Library/CoreServices/Menu Extras/TextInput.menu" \
        "/System/Library/CoreServices/Menu Extras/Clock.menu"

    # Disable guest account
    # sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false
}

# main {{{1}}}
echo -n "Power-up your OS X by defaults commands (y/N) "
read
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    # Ask for the administrator password upfront
    sudo -v

    # Keep-alive: update existing `sudo` time stamp until `.osx` has finished
    #while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
    while true
    do
        sudo -n true
        sleep 60;
        kill -0 "$$" || exit
    done 2>/dev/null &

    set_quicklook_preferences
    set_dock_preferences
    set_finder_preferences
    # set_keyboard_preferences
    set_safari_preferences
    set_terminal_preferences
    set_trackpad_preferences
    set_transmission_preferences
    set_ui_and_ux_preferences

    killall cfprefsd
    killall Dock
    killall Finder
    killall Safari
    killall SystemUIServer
    killall Transmission
fi
