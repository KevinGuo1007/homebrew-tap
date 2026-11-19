class Ruask < Formula
  desc "A command-line assistant for command lookup and command output explanation"
  homepage "https://ruask.vercel.app"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KevinGuo1007/ruask/releases/download/v0.1.1/ruask-aarch64-apple-darwin.tar.xz"
      sha256 "df9229a69917fe662c08becfd9f8c4996a8c040428f8c3a0cff727da6295d8b2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KevinGuo1007/ruask/releases/download/v0.1.1/ruask-x86_64-apple-darwin.tar.xz"
      sha256 "3acae79865320a92dd85df9a5af39de3a4cc99e85e6bc566f567fbb034920093"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/KevinGuo1007/ruask/releases/download/v0.1.1/ruask-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "969e7ad52ad51a567b6ba36110cab8d9873392d7c12b1ae8735ec8677b30dbf0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KevinGuo1007/ruask/releases/download/v0.1.1/ruask-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6444ff5fc8b43dfecb4a486f76d87033923b284059f7a6de23f2ff6ef797f498"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "ruask"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ruask"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ruask"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ruask"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
