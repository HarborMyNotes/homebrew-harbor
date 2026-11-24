#
# Copyright 2026 Cloudmanic Labs, LLC. All rights reserved.
# Date: 2026-11-16
#

# Homebrew cask for the Harbor Mac app (the direct-download build).
#
# The token is harbor-notes because `harbor` is already the CLI formula in this
# tap. Install with: brew install --cask harbormynotes/harbor/harbor-notes
#
# The url is the versioned download link the Sparkle appcast uses. The sha256 is
# for the DMG that link serves.
cask "harbor-notes" do
  version "1.1.2"
  sha256 "70f5b56ae3a373622f842e90d9b37f510d39e8c5c7fc1438420f193e18f0e4b3"

  url "https://app.harbor.my/download/mac/#{version}"
  name "Harbor"
  desc "Private, offline-first notes (Evernote alternative)"
  homepage "https://harbor.my/"

  # short_version, or livecheck reports "X.Y.Z,<build number>" instead of X.Y.Z.
  livecheck do
    url "https://harbor.my/appcast.xml"
    strategy :sparkle, &:short_version
  end

  # Sparkle updates the app in place, so a plain `brew upgrade` leaves it alone.
  auto_updates true
  # Keep in step with macOSMinimumVersion in harbor-swift's Project.swift.
  depends_on macos: :sequoia

  app "Harbor.app"

  # The app is not sandboxed, so its data sits straight in ~/Library. Only the
  # Share extension is sandboxed, so it alone gets a container.
  zap trash: [
    "~/Library/Application Scripts/group.my.harbor.app",
    "~/Library/Application Scripts/my.harbor.app.share",
    "~/Library/Application Support/Harbor",
    "~/Library/Caches/Harbor",
    "~/Library/Caches/my.harbor.app",
    "~/Library/Containers/my.harbor.app.share",
    "~/Library/Group Containers/group.my.harbor.app",
    "~/Library/HTTPStorages/my.harbor.app",
    "~/Library/Logs/Harbor",
    "~/Library/Preferences/my.harbor.app.plist",
    "~/Library/Saved Application State/my.harbor.app.savedState",
    "~/Library/WebKit/my.harbor.app",
  ]

  # The Mac App Store build is also /Applications/Harbor.app, so only one fits.
  caveats <<~EOS
    If you installed Harbor from the Mac App Store, you already have it.
    Do not install both.
  EOS
end
