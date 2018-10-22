class Dvips < Formula
  desc "Convert DVI to PostScript"
  homepage "https://tug.org/dvips/"
  # A local mirror but not a permanent URL. Try it first.
  url "http://mirror.ctan.org/systems/texlive/Source/texlive-20180414-source.tar.xz"
  # Not a local mirror but is a permanent URL. Try it second.
  mirror "ftp://tug.org/historic/systems/texlive/2018/texlive-20180414-source.tar.xz"
  sha256 "fe0036d5f66708ad973cdc4e413c0bb9ee2385224481f7b0fb229700a0891e4e"
  version "5.998"

  depends_on "pkg-config" => :build
  depends_on "kpathsea"

  def testdata
    prefix/"test"
  end

  def install
    chdir "texk/dvipsk" do
      # Configure, build, install
      system "./configure",
        "--disable-dependency-tracking",
        "--disable-silent-rules",
        "--enable-shared",
        "--with-system-kpathsea",
        "--prefix=#{prefix}"
      system "make", "install"

      # This path is required for post_install.
      pkgshare.install share/"texmf-dist"

      # Save a file for the test.
      testdata.install "testdata/eepic-nan.dvi"
    end
  end

  # This is the shared distribution configuration directory.
  def texmf_dist
    HOMEBREW_PREFIX/"share/texmf-dist"
  end

  def post_install
    # Create symlinks for all the TeX formulae installed.
    texmf_dist.mkpath
    chdir texmf_dist do
      Dir["../*/texmf-dist/*"].each do |p|
        ln_sf p, "."
      end
    end

    # Update the kpathsea filename database (ls-R files):
    # https://tug.org/texinfohtml/kpathsea.html#Filename-database
    system "mktexlsr"
  end

  test do
    # If this test passes, then kpathsea is working and dvips can correctly
    # process a file.
    system bin/"dvips", testdata/"eepic-nan.dvi"
  end
end
