class Claudeusage < Formula
  include Language::Python::Shebang

  desc "Token, cost and efficiency dashboard for Claude Code usage"
  homepage "https://github.com/ryuhemingway/claudeusage"
  url "https://github.com/ryuhemingway/claudeusage/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "074141982b0b159053d1732de60fcb4f4e0576b75c07b6ec3dcba9991fb730b5"
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
