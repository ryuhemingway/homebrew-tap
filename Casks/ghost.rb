cask "ghost" do
  version "1.0.3"
  sha256 "8b3283b0252d86b1be25104357ea224137b5922657f9a1d040df56a0263668d6"

  url "https://github.com/ryuhemingway/Ghost-App/releases/download/v#{version}/Ghost-v#{version}.zip"
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
