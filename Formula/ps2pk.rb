# Resources:
# * Gentoo: https://gitweb.gentoo.org/repo/gentoo.git/tree/app-text/ps2pkm

class Ps2pk < Formula
  desc "Generate PK fonts from Type 1 fonts"
  homepage "https://ctan.org/pkg/ps2pk"
  # A local mirror but not a permanent URL. Try it first.
  url "http://mirror.ctan.org/systems/texlive/Source/texlive-20180414-source.tar.xz"
  # Not a local mirror but is a permanent URL. Try it second.
  mirror "ftp://tug.org/historic/systems/texlive/2018/texlive-20180414-source.tar.xz"
  sha256 "fe0036d5f66708ad973cdc4e413c0bb9ee2385224481f7b0fb229700a0891e4e"
  version "1.8.20180414"

  depends_on "pkg-config" => :build
  depends_on "spl/tex/kpathsea"

  def testdata
    prefix/"test"
  end

  def install
    # Configuring and building in-tree is discouraged by the TeX Live folks.
    # So, we create a work directory and do our things there.
    workdir = buildpath/"work"
    workdir.mkpath

    chdir workdir do
      # Configure.
      system buildpath/"texk/ps2pk/configure",
        "--disable-dependency-tracking",
        "--disable-silent-rules",
        "--enable-shared",
        "--disable-static",
        "--with-system-kpathsea",
        "--prefix=#{prefix}"

      # Build and install.
      system "make", "install"

      # Save files for the test.
      testdata.install Dir["tests/{Symbol.afm,Symbol.pfb,Symbol10.300pk}"]
    end
  end

  test do
    # This tests conversion of a PFB (Printer Font Binary) to a PK.
    system bin/"ps2pk", testdata/"Symbol.pfb"
    assert compare_file testpath/"Symbol10.300pk", testdata/"Symbol10.300pk"
  end
end
