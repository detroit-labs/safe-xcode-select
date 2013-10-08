# safe-xcode-select
`safe-xcode-select` is a way for us to wrap `xcode-select` on the command line
to allow us to change the path to Xcode for an individual script, Jenkins task,
etc.

## Usage
`/path/to/safe-xcode-select /Applications/Xcode.app`

Pass the path to the Xcode app bundle, not to the `/Contents/Developer` path.
`safe-xcode-select` will append that path.

## Warning
This is not 100% safe. Please exercise caution. Don’t put this on a server that
is not otherwise secured.

## Installation

Copy to `/usr/local/bin` or wherever and run this command to give it the correct
permissions:

```Shell
sudo chown root:wheel /usr/local/bin/safe-xcode-select
sudo chmod 4755 /usr/local/bin/safe-xcode-select
```
