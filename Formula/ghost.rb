class Ghost < Formula
  desc "AI assistant menubar app for macOS"
  homepage "https://github.com/ryuhemingway/Ghost-App"
  url "https://github.com/ryuhemingway/Ghost-App/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  version "1.0.3"

  depends_on xcode: ["15.0", :build]

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    binpath = Utils.safe_popen_read("swift", "build", "-c", "release", "--show-bin-path").strip

    app = prefix/"Ghost.app"
    contents = app/"Contents"
    macos = contents/"MacOS"
    macos.mkpath

    (macos/"Ghost").install Dir["#{binpath}/Ghost"].first

    resources = contents/"Resources"
    resources.mkpath

    icon = buildpath/"script/Ghost.icns"
    resources.install icon if icon.exist?

    Dir.glob("#{binpath}/*.bundle").each { |b| resources.install b }

    sparkle = Dir.glob(buildpath/".build/**/Sparkle.xcframework/macos-*/Sparkle.framework").first
    if sparkle
      frameworks = contents/"Frameworks"
      frameworks.mkpath
      frameworks.install Pathname.new(sparkle)
      system "install_name_tool", "-add_rpath", "@executable_path/../Frameworks", "#{macos}/Ghost"
    end

    (contents/"Info.plist").write <<~PLIST
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>CFBundleExecutable</key>
        <string>Ghost</string>
        <key>CFBundleIdentifier</key>
        <string>com.local.Ghost</string>
        <key>CFBundleName</key>
        <string>Ghost</string>
        <key>CFBundleShortVersionString</key>
        <string>1.0.3</string>
        <key>CFBundleVersion</key>
        <string>103</string>
        <key>CFBundlePackageType</key>
        <string>APPL</string>
        <key>CFBundleIconFile</key>
        <string>Ghost</string>
        <key>LSMinimumSystemVersion</key>
        <string>14.0</string>
        <key>LSUIElement</key>
        <true/>
        <key>NSPrincipalClass</key>
        <string>NSApplication</string>
        <key>NSMicrophoneUsageDescription</key>
        <string>Ghost uses the microphone for dictation.</string>
        <key>NSSpeechRecognitionUsageDescription</key>
        <string>Ghost uses speech recognition to turn your voice into prompts.</string>
        <key>NSCalendarsUsageDescription</key>
        <string>Ghost uses Calendar access to read and create events you request.</string>
        <key>NSCalendarsFullAccessUsageDescription</key>
        <string>Ghost uses Calendar access to read and create events you request.</string>
        <key>NSRemindersUsageDescription</key>
        <string>Ghost uses Reminders access to create reminders you request.</string>
        <key>NSRemindersFullAccessUsageDescription</key>
        <string>Ghost uses Reminders access to create reminders you request.</string>
        <key>NSAppleEventsUsageDescription</key>
        <string>Ghost uses Apple Events only for requested local app automation such as Reminders fallback actions.</string>
      </dict>
      </plist>
    PLIST

    codesign_args = %W[--force --deep --sign - --identifier com.local.Ghost]
    system "codesign", *codesign_args, app.to_s
  end

  def caveats
    <<~EOS
      Ghost.app has been installed to:
        #{opt_prefix}/Ghost.app

      To launch from /Applications:
        cp -R #{opt_prefix}/Ghost.app /Applications/

      Then open it manually or run:
        open /Applications/Ghost.app
    EOS
  end
end
