# Notifiers

Cross-platform desktop notifications for macOS and Linux.

[![CI](https://github.com/tomas-stefano/notifiers/actions/workflows/ci.yml/badge.svg)](https://github.com/tomas-stefano/notifiers/actions/workflows/ci.yml)

## Install

```
gem install notifiers
```

## Requirements

- Ruby >= 3.0

## Usage

```ruby
require 'notifiers'
include Notifiers
```

### Auto Discover

Automatically detect and use an available notifier for your platform:

```ruby
auto_discover.title('Hello').message('World!').notify!
```

### macOS

#### terminal-notifier

Requires [terminal-notifier](https://github.com/julienXX/terminal-notifier): `brew install terminal-notifier`

```ruby
terminal_notifier.title('Hello').message('World!').sound('default').notify!
terminal_notifier.message('Click me').open('https://example.com').notify!
```

#### osascript (built-in)

Uses AppleScript, no installation required:

```ruby
osascript.title('Hello').message('World!').sound('Glass').notify!
osascript.title('Alert').subtitle('Status').message('Done!').notify!
```

### Linux / BSD

#### notify-send

Requires libnotify: `apt install libnotify-bin` or equivalent

```ruby
notify_send.title('Hello').message('World!').urgency(:critical).notify!
notify_send.title('Alert').message('Check this').expire_time(5000).notify!
```

`lib_notify` is an alias for `notify_send`.

#### dunstify

Requires [dunst](https://dunst-project.org/): `apt install dunst` or equivalent

```ruby
dunstify.title('Hello').message('World!').urgency(:low).notify!
dunstify.title('Update').message('Progress').timeout(3000).notify!
```

## Supported Notifiers

| Notifier | Platform | Command | Installation |
|----------|----------|---------|--------------|
| `terminal_notifier` | macOS | `terminal-notifier` | `brew install terminal-notifier` |
| `osascript` | macOS | `osascript` | Built-in |
| `notify_send` | Linux/BSD | `notify-send` | `apt install libnotify-bin` |
| `dunstify` | Linux/BSD | `dunstify` | `apt install dunst` |

## License

MIT
