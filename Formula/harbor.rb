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
      url "https://github.com/HarborMyNotes/harbor-cli/releases/download/v0.1.43/harbor-darwin-arm64"
      sha256 "5baa75660ad81615500a754c8ef33d3567b81c0089a2e87627a50bbffc5d30d4"
    end
    on_intel do
      url "https://github.com/HarborMyNotes/harbor-cli/releases/download/v0.1.43/harbor-darwin-amd64"
      sha256 "fabc16880b1f2315ff1434deb184a6854334f5c84d812a32e8ec52eaf6299d3e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/HarborMyNotes/harbor-cli/releases/download/v0.1.43/harbor-linux-arm64"
      sha256 "74486278b5be3f36fe6d99ec8d7f10953799fcbe27d12c061718d646261da3f3"
    end
    on_intel do
      url "https://github.com/HarborMyNotes/harbor-cli/releases/download/v0.1.43/harbor-linux-amd64"
      sha256 "1e11227b439397dc1b586208cd7093426031ed75c1cc0dbd4b83004db08b5be1"
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
