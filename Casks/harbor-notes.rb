#
# Copyright 2026 Cloudmanic Labs, LLC. All rights reserved.
# Date: 2026-11-16
#

# Homebrew cask for the Harbor Mac app (the direct-download build).
#
# The token is harbor-notes because `harbor` is already the CLI formula in this
# tap. Install with: brew install --cask harbormynotes/harbor/harbor-notes
#
# The url is the same versioned download link the Sparkle appcast uses. It
# redirects to a short-lived link for the DMG, so the sha256 is the DMG's.
cask "harbor-notes" do
  version "1.0.92"
  sha256 "afa6a5878701e7d675e8d5f10414c30e23c4850af1547ec90eaad38e81e6743a"

  url "https://app.harbor.my/download/mac/#{version}"
  name "Harbor"
  desc "Private, offline-first notes (Evernote alternative)"
  homepage "https://harbor.my/"

  # short_version, or livecheck reports "1.0.92,<build number>" instead of 1.0.92.
  livecheck do
    url "https://harbor.my/appcast.xml"
    strategy :sparkle, &:short_version
  end

  # Sparkle updates the app in place, so a plain `brew upgrade` leaves it alone.
  auto_updates true
  # Keep in step with macOSMinimumVersion in harbor-swift's Project.swift.
  depends_on macos: :sequoia

  app "Harbor.app"

  # The app is not sandboxed, so it writes straight into ~/Library. Its Share
  # extension is sandboxed, so it gets its own container, and the two pass
  # captured notes through the group container.
  zap trash: [
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

  # The Mac App Store build is the same app with the same bundle id, so the two
  # cannot sit side by side in /Applications.
  caveats <<~EOS
    If you installed Harbor from the Mac App Store, you already have it.
    Do not install both.
  EOS
end
