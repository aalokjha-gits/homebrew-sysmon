class Sysmon < Formula
  desc "Lightweight system monitoring dashboard with web UI"
  homepage "https://github.com/aalokjha-gits/sysmon"
  version "0.6.0"
  license "MIT"

  # Linux users: use install.sh or download from releases
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/aalokjha-gits/sysmon/releases/download/v#{version}/sysmon-universal"
    sha256 "13e1830b6036972678dc7785cd8b16293f45f68d212a9bda467ab7d61eef12c7"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/aalokjha-gits/sysmon/releases/download/v#{version}/sysmon-x86_64-apple-darwin"
    sha256 "ed9c5c9e1c0e73a90c654090b6cbdc3fc9f91738710572ec2bf0d100e7fdc808"
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
