class Sysmon < Formula
  desc "Lightweight system monitoring dashboard with web UI"
  homepage "https://github.com/aalokjha-gits/sysmon"
  version "0.3.0"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/aalokjha-gits/sysmon/releases/download/v#{version}/sysmon-universal"
    sha256 "0b34ccd15db10646694c7f51c3d8c0213eb097de4329016f5609070ff2a2747d"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/aalokjha-gits/sysmon/releases/download/v#{version}/sysmon-x86_64-apple-darwin"
    sha256 "679b29055a5d1d37344ab6c922ea90136219070a46aaa9163c4c7ec7af4fafa8"
  end

  def install
    if build.head?
      system "cargo", "build", "--release"
      bin.install "target/release/sysmon"
    else
      bin.install Dir.glob("sysmon*").first => "sysmon"
    end
  end

  def caveats
    <<~EOS
      To start sysmon:
        sysmon

      To start on a custom port:
        sysmon --port 8080

      To start without opening browser:
        sysmon --no-browser

      Configuration: ~/.config/sysmon/config.toml
    EOS
  end

  test do
    assert_match "sysmon", shell_output("#{bin}/sysmon --version")
  end
end
