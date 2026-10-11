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
      url "https://github.com/HarborMyNotes/harbor-cli/releases/download/v0.1.45/harbor-darwin-arm64"
      sha256 "46368f6d8f74e4ddc8dbf5f871b50d03ed12884e28db78d858e61bd7755abb76"
    end
    on_intel do
      url "https://github.com/HarborMyNotes/harbor-cli/releases/download/v0.1.45/harbor-darwin-amd64"
      sha256 "a1d7a8167e7a318cf83f7697023bdeaf4e5c08eba4d6379984a443d02628c19b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/HarborMyNotes/harbor-cli/releases/download/v0.1.45/harbor-linux-arm64"
      sha256 "4238953f69104875e6761b59c0a226a774e4f728a05ea9ffbc22c936e201fc71"
    end
    on_intel do
      url "https://github.com/HarborMyNotes/harbor-cli/releases/download/v0.1.45/harbor-linux-amd64"
      sha256 "b90c464be39a454aaa14373553fc1800f5ad05c63ade28eec11e0d8a31258fc0"
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
