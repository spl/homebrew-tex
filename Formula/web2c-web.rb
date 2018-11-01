class Web2cWeb < Formula
  desc "(C)WEB tools from Web2C"
  homepage "https://tug.org/web2c/"
  # A local mirror but not a permanent URL. Try it first.
  url "http://mirror.ctan.org/systems/texlive/Source/texlive-20180414-source.tar.xz"
  # Not a local mirror but is a permanent URL. Try it second.
  mirror "ftp://tug.org/historic/systems/texlive/2018/texlive-20180414-source.tar.xz"
  sha256 "fe0036d5f66708ad973cdc4e413c0bb9ee2385224481f7b0fb229700a0891e4e"
  version "20180414"

  depends_on "pkg-config" => :build
  depends_on "spl/tex/kpathsea"

  conflicts_with "cweb", :because => "both install the same binaries"

  def install
    srcdir = buildpath/"texk/web2c"
    chdir srcdir do

      # Configuring and building in-tree is discouraged by the TeX Live folks.
      # So, we create a work directory and do our things there.
      workdir = srcdir/"work"
      workdir.mkpath

      chdir workdir do
        # Configure, build, install
        system "../configure",
          "--disable-dependency-tracking",
          "--disable-silent-rules",
          "--disable-static",
          "--enable-shared",
          # kpathsea is required.
          "--with-system-kpathsea",
          # These --with-system-* flags are not strictly necessary for this
          # formula since none of the components depend on them; however, they
          # serve as sanity checks for configuration.
          "--with-system-cairo",
          "--with-system-freetype2",
          "--with-system-gmp",
          "--with-system-graphite2",
          "--with-system-harfbuzz",
          "--with-system-icu",
          "--with-system-libpng",
          "--with-system-mpfr",
          "--with-system-pixman",
          "--with-system-poppler",
          "--with-system-ptexenc",
          "--with-system-teckit",
          "--with-system-xpdf",
          "--with-system-zlib",
          "--with-system-zziplib",
          "--without-x",
          # These are what we are building.
          # ctangle, ctie, cweave, tangle, and tie are always built.
          "--enable-web-progs", # pooltype, weave
          # Disable the other core Web2C packages.
          "--disable-tex", # TeX
          "--disable-mp", # MetaPost
          "--disable-mf", # Metafont
          "--disable-synctex", # SyncTeX
          # These extensions to TeX are available in other formulae.
          "--disable-etex",
          "--disable-xetex",
          "--disable-aleph",
          "--disable-pdftex",
          "--disable-luatex",
          "--disable-luatex53",
          "--disable-luajittex",
          # These extensions to Metafont are available in other formulae.
          "--disable-mflua",
          "--disable-mfluajit",
          # These require ptexenc and are available in other formulae.
          "--disable-ptex",
          "--disable-eptex",
          "--disable-uptex",
          "--disable-euptex",
          "--disable-pmp",
          "--disable-upmp",
          "--prefix=#{prefix}"
        system "make"

        # 'make install' includes irrelevant files. So, we use DESTDIR and
        # selective install instead.
        system "make", "install", "DESTDIR=#{buildpath}"

        %w[ ctangle ctie cweave tangle tie
            pooltype weave ].each do |n|
          bin.install "#{buildpath}#{bin}/#{n}"
          man1.install "#{buildpath}#{man1}/#{n}.1"
        end
        # Some of the man pages include this one using troff '.so'.
        man1.install "#{buildpath}#{man1}/cweb.1"
      end
    end
  end

  def caveats; <<~EOS
    This formula installs the WEB and CWEB tools from the Web2C implementation.
    However, if you just want to use CWEB, we recommend the 'cweb' formula in
    homebrew-core since it is newer.

    The man pages do not work with the 'less' flag -F (--quit-if-one-screen). If
    you have a problem, try clearing the $LESS variable:

      LESS= man ctangle

  EOS
  end

  test do
    (testpath/"test.w").write <<~EOS
      @* Hello World
      This is a minimal program written in CWEB.
      @c
      #include <stdio.h>
      void main() { printf("Hello world!"); }
    EOS
    system bin/"ctangle", "test.w"
    system ENV.cc, "test.c", "-o", "hello"
    assert_equal "Hello world!", pipe_output("./hello")
  end
end
