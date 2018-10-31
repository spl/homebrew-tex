class Epstopdf < Formula
  desc "Con­vets EPS to PDF"
  homepage "https://tug.org/epstopdf/"
  # We use svn to get a particular revision because the releases are not
  # versioned and the TeX Live distribution does not include the man page and
  # tests.
  url "svn://tug.org/texlive/trunk/Build/extra/epstopdf", :revision => "48681"
  version "2.28"

  depends_on "ghostscript"

  def testdata
    prefix/"test"
  end

  def install
    # Save the script.
    libexec.install "#{name}.pl"
    script = libexec/"#{name}.pl"

    # Install symlinks.
    bin.install_symlink script => name
    bin.install_symlink script => "r#{name}" # restricted

    # Install man pages.
    man1.install Dir["*.1"]

    # Save the test.
    testdata.install "test-simple.eps"
  end

  test do
    system bin/"epstopdf", testdata/"test-simple.eps", "--outfile=test-simple.pdf"
    system bin/"repstopdf", testdata/"test-simple.eps", "--outfile=test-simple.pdf"
  end
end
