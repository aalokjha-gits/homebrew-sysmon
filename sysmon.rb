class Sysmon < Formula
  desc "Lightweight system monitoring dashboard with web UI"
  homepage "https://github.com/aalokjha-gits/sysmon"
  version "0.5.0"
  license "MIT"

  # Linux users: use install.sh or download from releases
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/aalokjha-gits/sysmon/releases/download/v#{version}/sysmon-universal"
    sha256 "2c49f5c4f9686d67bde1f610f9fb89a5bd8a5ea34fa8ebacc108b02ee15f5906"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/aalokjha-gits/sysmon/releases/download/v#{version}/sysmon-x86_64-apple-darwin"
    sha256 "ff9e111ffe831befcbfe47e3c898f0205cc4a33a471e8aae62253731d7ec8b6f"
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
