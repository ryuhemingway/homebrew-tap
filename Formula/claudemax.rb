class Claudemax < Formula
  include Language::Python::Shebang

  desc "Token, cost and efficiency dashboard for Claude Code usage"
  homepage "https://github.com/ryuhemingway/ClaudeMaxing"
  url "https://github.com/ryuhemingway/ClaudeMaxing/archive/refs/tags/v2.1.0.tar.gz"
  sha256 "e04ce9a8e16906ab45c81935cf4285867997948aec641a4623ed9cb188e79f8e"
  license "MIT"

  depends_on "python@3.13"

  def install
    # Pin the interpreter to the one we depend on rather than whatever
    # `env python3` happens to resolve to on the user's PATH.
    rewrite_shebang detected_python_shebang, "claudemax"
    bin.install "claudemax"
  end

  test do
    assert_match "claudemax", shell_output("#{bin}/claudemax --help")

    # With no transcripts on disk the tool should exit non-zero with a
    # readable message rather than a traceback.
    output = shell_output("env -u CLAUDE_CONFIG_DIR HOME=#{testpath} #{bin}/claudemax 2>&1", 1)
    assert_match "no transcripts at", output
  end
end
