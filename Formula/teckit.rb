class Teckit < Formula
  desc "Text Encoding Conversion toolkit"
  homepage "https://github.com/silnrsi/teckit"
  url "https://github.com/silnrsi/teckit/archive/v2.5.8.tar.gz"
  sha256 "0ea52b1304f430aaebff99fec355bc7e4ad75b16ba58959fae5079627f925f93"
  #url "https://github.com/silnrsi/teckit/releases/download/v2.5.8/teckit-2.5.8.tar.gz"
  #sha256 "35df1f68f1083791a884b12947bfab4de2cd20bac8f36793ed6638da2f24be01"

  depends_on "libtool" => :build
  depends_on "automake" => :build
  depends_on "autoconf" => :build

  # Other dependencies:
  #   * zlib - included in macOS
  #   * libexpat - included in macOS

  def testdata
    prefix/"test"
  end

  def install
    # Generate ./configure
    system "./autogen.sh"

    # Create a build directory as recommended by TECkit developers.
    builddir = buildpath/"build"
    builddir.mkpath

    chdir builddir do
      # Configure, build, install
      system "../configure",
        "--disable-debug",
        "--disable-dependency-tracking",
        "--disable-silent-rules",
        "--disable-static",
        "--enable-final",
        "--enable-shared",
        "--with-system-zlib",
        "--prefix=#{prefix}"
      system "make", "install"

      # Save files for the test.
      testdata.install Dir["../test/{SILGreek2004-04-27.map,SILGreek2004-04-27.uncompressed.tec.orig}"]
    end
  end

  test do
    # This is the first test taken from the teckit tests.
    system bin/"teckit_compile", testdata/"SILGreek2004-04-27.map", "-z", "-o",
      "SILGreek.uncompressed.tec"
    assert compare_file testdata/"SILGreek2004-04-27.uncompressed.tec.orig",
      testpath/"SILGreek.uncompressed.tec"
  end
end
