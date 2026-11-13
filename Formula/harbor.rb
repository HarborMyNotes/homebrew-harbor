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
      url "https://github.com/HarborMyNotes/harbor-cli/releases/download/v0.1.55/harbor-darwin-arm64"
      sha256 "69ccdebe10305b8b98917181a3ddf4ad041c9119c56173ddadac7cf94c26f44f"
    end
    on_intel do
      url "https://github.com/HarborMyNotes/harbor-cli/releases/download/v0.1.55/harbor-darwin-amd64"
      sha256 "1bb35517d83fce333f1424047285090bd38d9b88d4777e8aefeece62bc31c382"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/HarborMyNotes/harbor-cli/releases/download/v0.1.55/harbor-linux-arm64"
      sha256 "337a388af0e7916f0c2435a067521b52cbdc3383ef251ce0c4579c493941875c"
    end
    on_intel do
      url "https://github.com/HarborMyNotes/harbor-cli/releases/download/v0.1.55/harbor-linux-amd64"
      sha256 "0bcfc592f0aa6847a36eb6a7ad90d40ad50346afe1a65247d2f5e476caf57ed8"
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
