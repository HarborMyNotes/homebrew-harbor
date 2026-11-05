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
      url "https://github.com/HarborMyNotes/harbor-cli/releases/download/v0.1.53/harbor-darwin-arm64"
      sha256 "3bde89bf56f6f28bd6d4b0260de503168b458436acf5a0286f5e3e60c5feb628"
    end
    on_intel do
      url "https://github.com/HarborMyNotes/harbor-cli/releases/download/v0.1.53/harbor-darwin-amd64"
      sha256 "0d5c58514fe0344b6a420f33f9f2bd1ae1dfd4dfdaecb99f4602cbb1ba24a92b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/HarborMyNotes/harbor-cli/releases/download/v0.1.53/harbor-linux-arm64"
      sha256 "3e04f474e6ae47512cc153e239e45a7d4915993a6f258b134ab1f8b7650a321b"
    end
    on_intel do
      url "https://github.com/HarborMyNotes/harbor-cli/releases/download/v0.1.53/harbor-linux-amd64"
      sha256 "625544a6d1add7e42b88b935a3fe14189538d89177f314639afb589d57952e7e"
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
