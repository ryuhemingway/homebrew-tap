class Claudeusage < Formula
  include Language::Python::Shebang

  desc "Token, cost and efficiency dashboard for Claude Code usage"
  homepage "https://github.com/ryuhemingway/claudeusage"
  url "https://github.com/ryuhemingway/claudeusage/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "a43379beed9f2a0edea2cd49d701adb0929b58b55e1e0b5700d4aa30a7cf11bd"
  license "MIT"

  depends_on "python@3.13"

  def install
    # Pin the interpreter to the one we depend on rather than whatever
    # `env python3` happens to resolve to on the user's PATH.
    rewrite_shebang detected_python_shebang, "claudeusage"
    bin.install "claudeusage"
  end

  test do
    assert_match "claudeusage", shell_output("#{bin}/claudeusage --help")

    # With no transcripts on disk the tool should exit non-zero with a
    # readable message rather than a traceback.
    output = shell_output("env -u CLAUDE_CONFIG_DIR HOME=#{testpath} #{bin}/claudeusage 2>&1", 1)
    assert_match "no transcripts at", output
  end
end
