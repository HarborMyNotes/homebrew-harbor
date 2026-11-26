#
# Copyright 2026 Cloudmanic Labs, LLC. All rights reserved.
# Date: 2026-08-27
#

# Homebrew formula for the Harbor CLI.
#
# Installs the prebuilt binary that harbor-cli's release workflow publishes for
# the current platform. The URLs and checksums below are rewritten on every
# release by that workflow; nothing here is edited by hand.
#
# There is deliberately no `version` stanza: Homebrew scans the version out of
# the pinned url, so the version it reports cannot drift from the binary it
# fetched.
#
# The url MUST stay pinned to an explicit vX.Y.Z tag rather than
# releases/latest/. Homebrew keys its download cache on the url, so a floating
# url makes every version look identical to `brew upgrade` — which is how an
# install ends up stuck many releases behind while the formula claims to be
# current.
class Harbor < Formula
  desc "Command-line client for the Harbor notes API"
  homepage "https://github.com/HarborMyNotes/harbor-cli"
  license "MIT"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/HarborMyNotes/harbor-cli/releases/download/v0.1.57/harbor-darwin-arm64"
      sha256 "fb1d707b1bd2924fa75f6c169afb3b3bcca75019b3d7d89d3d14123bda553c2d"
    end
    on_intel do
      url "https://github.com/HarborMyNotes/harbor-cli/releases/download/v0.1.57/harbor-darwin-amd64"
      sha256 "2085ce605e0b2ce7aef9249c1b4ce31a33fbf83969099605f53cc6b35b994456"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/HarborMyNotes/harbor-cli/releases/download/v0.1.57/harbor-linux-arm64"
      sha256 "477e8544131e89c00547aea1c47c6faca629103461eac1720f2911a88d8caaab"
    end
    on_intel do
      url "https://github.com/HarborMyNotes/harbor-cli/releases/download/v0.1.57/harbor-linux-amd64"
      sha256 "4c14f6fe5616a1b2789dfb3785d8412e2fb7683f859f86c7abe5873d4f142843"
    end
  end

  # The release asset is a bare executable, so Homebrew stages it under its own
  # name (harbor-darwin-arm64 and friends) rather than unpacking an archive.
  def install
    bin.install stable.url.split("/").last => "harbor"
  end

  # Asserts the real version, not just that the command runs. The version comes
  # from the url while the string being matched comes from the binary's ldflags,
  # so a mismatch means the release build and the formula disagree.
  test do
    assert_match "harbor version v#{version}", shell_output("#{bin}/harbor --version")
  end
end
