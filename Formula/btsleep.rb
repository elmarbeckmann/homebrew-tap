class Btsleep < Formula
  desc "Turn Bluetooth off while a Mac sleeps to stop DarkWake battery drain"
  homepage "https://github.com/elmarbeckmann/btsleep"
  url "https://github.com/elmarbeckmann/btsleep/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "2374388c0dbb75017841578753a3215a69830fdaae0c8baf0355194e592a0a33"
  license "MIT"

  depends_on :macos

  def install
    system "swiftc", "-O", "-o", "btsleep", "btsleep.swift"
    bin.install "btsleep"
  end

  service do
    run opt_bin/"btsleep"
    keep_alive true
    log_path var/"log/btsleep.log"
    error_log_path var/"log/btsleep.log"
  end

  test do
    assert_predicate bin/"btsleep", :executable?
  end
end
