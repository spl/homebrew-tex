class Latexmk < Formula
  desc "Script for running LaTeX, BibTeX, dvips, etc."
  homepage "http://personal.psu.edu/jcc8//software/latexmk-jcc/"
  url "http://personal.psu.edu/jcc8//software/latexmk-jcc/latexmk-461.zip"
  sha256 "6ab3fe2fb80f7dd94805c1094dc670d8930c45b33774cb308dc5cd2357007274"
  version "4.6.1"

  def install
    # Save the script.
    libexec.install "#{name}.pl"
    script = libexec/"#{name}.pl"

    # Install symlinks.
    bin.install_symlink script => name

    # Install man pages.
    man1.install "#{name}.1"
  end

  test do
    # This only tests that the script runs. We would need to depend on other
    # tools (e.g. LaTeX) to test inputs.
    system bin/"latexmk", "-v"
  end
end
