class Web2cTex < Formula
  desc "TeX, BibTeX, DVI utilities, font utilities, & SyncTeX from Web2C"
  homepage "https://tug.org/web2c/"
  # A local mirror but not a permanent URL. Try it first.
  url "http://mirror.ctan.org/systems/texlive/Source/texlive-20180414-source.tar.xz"
  # Not a local mirror but is a permanent URL. Try it second.
  mirror "ftp://tug.org/historic/systems/texlive/2018/texlive-20180414-source.tar.xz"
  sha256 "fe0036d5f66708ad973cdc4e413c0bb9ee2385224481f7b0fb229700a0891e4e"
  version "20180414"

  depends_on "pkg-config" => :build
  depends_on "spl/tex/kpathsea"

  def install
    srcdir = buildpath/"texk/web2c"
    chdir srcdir do

      # Configuring and building in-tree is discouraged by the TeX Live folks.
      # So, we create a work directory and do our things there.
      workdir = srcdir/"work"
      workdir.mkpath

      chdir workdir do
        # Configure. See <texlive-source>/texk/web2c/ac/web2c.ac for defaults.
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
          "--enable-web-progs", # bibtex, dvi utils, font utils
          "--enable-tex", # TeX
          # SyncTeX is not strictly part of the Web2C implementation and it is
          # not (according to TeX Live's default) use by TeX itself. However, it
          # is used downstream by pdfTeX and others and it doesn't have any
          # dependencies, so we include it here rather than create another
          # formula just for it.
          "--enable-synctex",
          # Disable the other core Web2C packages.
          "--disable-mp", # MetaPost
          "--disable-mf", # Metafont
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

        # Build.
        system "make"

        # Install. 'make install' includes irrelevant files. So, we use DESTDIR
        # and selective install instead.
        system "make", "install", "DESTDIR=#{buildpath}"

        lib.install Dir["#{buildpath}#{lib}/libsynctex*.dylib"]

        # We can divide these into different formula if later desired.
        %w[ tex initex patgen
            bibtex
            dvicopy dvitype
            gftodvi gftopk gftype pktogf pktype pltotf tftopl vftovp vptovf
            synctex ].each do |n|
          bin.install "#{buildpath}#{bin}/#{n}"
          man1.install "#{buildpath}#{man1}/#{n}.1"
        end
      end
    end
  end
end
