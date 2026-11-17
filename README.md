<!--
Copyright 2026 Cloudmanic Labs, LLC. All rights reserved.
Date: 2026-08-27
-->

# Harbor Homebrew tap

The official Homebrew tap for [Harbor](https://harbor.my) notes. It has two things:

| What | Name | Install |
|---|---|---|
| The Mac app | `harbor-notes` (cask) | `brew install --cask harbormynotes/harbor/harbor-notes` |
| The CLI | `harbor` (formula) | `brew install harbor` |

## Install

```bash
brew tap HarborMyNotes/harbor
brew trust HarborMyNotes/harbor
```

Then install the app, the CLI, or both:

```bash
brew install --cask harbormynotes/harbor/harbor-notes   # the Mac app
brew install harbor                                      # the CLI
```

### Why the `trust` step

Homebrew 6.0 will not run code from a tap outside its official ones until you have
approved that tap once. Skip it and Homebrew stops with an error instead of installing
anything. You only do it once per machine.

## The Mac app (`harbor-notes`)

Installs `Harbor.app` into `/Applications`. It is the same signed, notarized
direct-download build as the download on [harbor.my](https://harbor.my). It needs macOS 15
(Sequoia) or later.

- **Updates:** the app updates itself, so `brew upgrade` skips it. To make Homebrew update
  it anyway, run `brew upgrade --greedy harbor-notes`.
- **Mac App Store:** if you installed Harbor from the Mac App Store, you already have it.
  Do not install both. They are the same app.
- **Remove it:** `brew uninstall --cask harbor-notes`. Add `--zap` to also delete Harbor's
  local data on this Mac, including any change that has not synced yet.

## The CLI (`harbor`)

The prebuilt `harbor` binary for your platform, published by the
[harbor-cli release workflow](https://github.com/HarborMyNotes/harbor-cli/releases) and
verified against the SHA-256 in that release's `checksums.txt`. macOS and Linux, Intel
and ARM. Upgrade later with `brew upgrade harbor`.

Not using Homebrew? `curl -fsSL https://harbor.my/install.sh | sh`, or download a binary
straight from the [latest release](https://github.com/HarborMyNotes/harbor-cli/releases/latest).

## Maintenance

`Formula/harbor.rb` is updated automatically — harbor-cli's release workflow rewrites the
URLs and checksums on every release and pushes the commit here. It is not edited by hand.

`Casks/harbor-notes.rb` holds the Mac app's version and the SHA-256 of that version's DMG.
Change both together. Take the SHA-256 from the DMG the release workflow built, not from a
fresh download. `brew livecheck harbor-notes` shows the newest version in the appcast.

## License

The files in this tap are MIT licensed.
