# 2.0.0

Breaking changes:

* Remove Growl support (project retired)
* Remove Knotify support (KDE3 dcop deprecated)
* Require Ruby >= 3.0

New features:

* Add TerminalNotifier for macOS (Notification Center via terminal-notifier)
* Add Osascript for macOS (built-in AppleScript notifications)
* Add Dunstify for Linux/BSD (dunst notification daemon)
* Auto discover now works across all platforms and notifiers

Other changes:

* Replace Travis CI with GitHub Actions
* Update RSpec to ~> 3.13
* Add frozen_string_literal to all files

# 1.2.1

* Implementing auto discover, just for Growl now.

# 1.2.0

* When the Growl notify command doesn't exist, show a better error message.

# 1.1.0

* Add knotify to notifications message

# 1.0.0

* Add growl to notifications message
* Add lib-notify to notifications message