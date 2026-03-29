class Sysmon < Formula
  desc "Lightweight system monitoring dashboard with web UI"
  homepage "https://github.com/aalokjha-gits/sysmon"
  version "0.5.0"
  license "MIT"

  # Linux users: use install.sh or download from releases
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/aalokjha-gits/sysmon/releases/download/v#{version}/sysmon-universal"
    sha256 "dc8035127ca821ebe28f819a72211ffc28447273167eab254de99b87017a3cdd"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/aalokjha-gits/sysmon/releases/download/v#{version}/sysmon-x86_64-apple-darwin"
    sha256 "eb70eeb0093ea1d624a32bceaba31f318364eac9edf6a9cfde2846763694a93b"
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
