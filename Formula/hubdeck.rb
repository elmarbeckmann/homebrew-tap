class Hubdeck < Formula
  desc "Control Philips Hue, IKEA DIRIGERA and tado from an Elgato Stream Deck"
  homepage "https://github.com/elmarbeckmann/hubdeck"
  url "https://github.com/elmarbeckmann/hubdeck/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "a4bf71ac595df4c6aa3d11d428542149195a56772324c51f8a2fc3f96f9b0c27"
  license "MIT"

  depends_on "hidapi"
  depends_on :macos
  depends_on "uv"

  def install
    # uv reads the pinned versions from hubdeck.py.lock next to the script.
    libexec.install "hubdeck.py", "hubdeck.py.lock"
    (bin/"hubdeck").write <<~SH
      #!/bin/sh
      exec "#{formula_opt_bin("uv")}/uv" run --script "#{libexec}/hubdeck.py" "$@"
    SH
  end

  service do
    run [opt_bin/"hubdeck", "serve"]
    keep_alive true
    log_path var/"log/hubdeck.log"
    error_log_path var/"log/hubdeck.log"
  end

  test do
    assert_match "ok", shell_output("#{bin}/hubdeck test 2>&1")
  end
end
