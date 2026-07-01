cask "ghost" do
  version "1.0.3"
  sha256 "662102297d50e3f4faecda3ad1d112baeaa0eeed5e4ba2ad58d36bdab1fe782d"

  url "https://integratedagentics.com/ghost/Ghost-#{version}.zip"
  name "Ghost"
  desc "AI assistant menubar app for macOS"
  homepage "https://github.com/ryuhemingway/Ghost-App"

  auto_updates true
  depends_on macos: ">= :sonoma"

  app "Ghost.app"

  zap trash: [
    "~/Library/Application Support/Ghost",
    "~/Library/Preferences/com.local.Ghost.plist",
  ]
end
