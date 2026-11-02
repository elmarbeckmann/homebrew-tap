class Wakemeupbt < Formula
  desc "Turn Bluetooth off while a Mac sleeps to stop DarkWake battery drain"
  homepage "https://github.com/elmarbeckmann/WakeMeUpBT"
  url "https://github.com/elmarbeckmann/WakeMeUpBT/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "11bcb1f3d24085bb67fcf67f85985571be2ab69dbf870a3ea5a79c6a69d0926e"
  license "MIT"

  depends_on :macos

  def install
    system "swiftc", "-O", "-o", "wakemeupbt", "wakemeupbt.swift"
    bin.install "wakemeupbt"
  end

  service do
    run opt_bin/"wakemeupbt"
    keep_alive true
    log_path var/"log/wakemeupbt.log"
    error_log_path var/"log/wakemeupbt.log"
  end

  test do
    assert_predicate bin/"wakemeupbt", :executable?
  end
end
