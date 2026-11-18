class Ruask < Formula
  desc "A command-line assistant for command lookup and command output explanation"
  homepage "https://ruask.vercel.app"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KevinGuo1007/ruask/releases/download/v0.1.0/ruask-aarch64-apple-darwin.tar.xz"
      sha256 "829602cfa2baa8ac1e78468f74736744450b0c85b0d6a2acc82e51a1b8c67fd2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KevinGuo1007/ruask/releases/download/v0.1.0/ruask-x86_64-apple-darwin.tar.xz"
      sha256 "b9e752e84328b2fe5791de7d708fa58f35b34737dabcbb38f7900a9a4acbfca3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/KevinGuo1007/ruask/releases/download/v0.1.0/ruask-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f258a07f026ea1d936da0b7a8b929e28075e14e3817011633652158a5faf75bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KevinGuo1007/ruask/releases/download/v0.1.0/ruask-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "131517a9b8378a056074fba52c480303ff63a62c289646d2707059fe4c551a43"
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
