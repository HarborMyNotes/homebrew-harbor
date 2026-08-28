<!--
Copyright 2026 Cloudmanic Labs, LLC. All rights reserved.
Date: 2026-08-27
-->

# Harbor Homebrew tap

The official Homebrew tap for the [Harbor CLI](https://github.com/HarborMyNotes/harbor-cli) —
a command-line client for [Harbor](https://harbor.my) notes.

## Install

```bash
brew tap HarborMyNotes/harbor
brew trust HarborMyNotes/harbor
brew install harbor
```

Then upgrade later with `brew upgrade harbor`.

### Why the `trust` step

Homebrew 6.0 will not run code from a tap outside its official ones until you have
approved that tap once. Skip it and Homebrew stops with an error instead of installing
anything. You only do it once per machine.

## What this installs

The prebuilt `harbor` binary for your platform, published by the
[harbor-cli release workflow](https://github.com/HarborMyNotes/harbor-cli/releases) and
verified against the SHA-256 in that release's `checksums.txt`. macOS and Linux, Intel
and ARM.

Not using Homebrew? `curl -fsSL https://harbor.my/install.sh | sh`, or download a binary
straight from the [latest release](https://github.com/HarborMyNotes/harbor-cli/releases/latest).

## Maintenance

`Formula/harbor.rb` is updated automatically — harbor-cli's release workflow rewrites the
URLs and checksums on every release and pushes the commit here. It is not edited by hand.

## License

MIT, same as the CLI itself.
