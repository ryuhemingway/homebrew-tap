class ResetWifi < Formula
  desc "Refresh your Mac's Wi-Fi radio to get a new private address"
  homepage "https://github.com/ryuhemingway/update-wifi"
  url "https://github.com/ryuhemingway/update-wifi/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "b80dd463ea86e34aa2550a1a738f7cda4b34e1f963848dae780f4dc653c2073f"
  version "1.0.0"

  def install
    bin.install "bin/reset-wifi"
  end

  def caveats
    <<~EOS
      Add this to your ~/.zshrc for the `reset wifi` shortcut:

        reset() {
          if [[ "$1" == "wifi" ]]; then
            shift
            command reset-wifi "$@"
          else
            command reset "$@"
          fi
        }
    EOS
  end
end
