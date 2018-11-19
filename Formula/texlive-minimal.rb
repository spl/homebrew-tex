class TexliveMinimal < Formula
  desc "Minimal TeX Live distribution"
  homepage "https://www.tug.org/texlive/"
  # A local mirror but not a permanent URL. Try it first.
  url "http://mirror.ctan.org/systems/texlive/Source/texlive-20180414-source.tar.xz"
  # Not a local mirror but is a permanent URL. Try it second.
  mirror "ftp://tug.org/historic/systems/texlive/2018/texlive-20180414-source.tar.xz"
  sha256 "fe0036d5f66708ad973cdc4e413c0bb9ee2385224481f7b0fb229700a0891e4e"
  version "20180414"

  option "with-test", "Run tests after installation"
  option "without-strip", "Don't strip binaries"

  #depends_on "ghostscript"

  # This file is required by fmtutil.pl but not included in 'texlive-*-source.tar.xz'.
  resource "mktexlsr.pl" do
    url "https://tug.org/svn/texlive/trunk/Master/texmf-dist/scripts/texlive/mktexlsr.pl?revision=38001&view=co"
    sha256 "6bf8fb0314cff867a7605ccca51722efe0d1231ab3074e1482060dc0099891c0"
  end

  # These are the missing updmap entries for the standard PostScript fonts.
  resource "texmf-dist/fonts/map/dvips/tetex" do
    url "svn://tug.org/texlive/trunk/Master/texmf-dist/fonts/map/dvips/tetex", :revision => "31860"
  end

  # Extra files for epstopdf
  resource "epstopdf" do
    url "svn://tug.org/texlive/trunk/Build/extra/epstopdf", :revision => "48681"
  end

  patch do
    url "http://www.linuxfromscratch.org/patches/blfs/8.3/texlive-20180414-source-upstream_fixes-1.patch"
    sha256 "8f42a828ac7d607fce59c1360e78bf8e2996979ffb902e81ecc41f13a4871b39"
  end

  # texmf.cnf contains search paths and directories used by kpathsea. We patch
  # these to fit our Homebrew formula directory structure.
  patch :DATA

  # Path used by 'install' as test file destination and 'test' as source.
  def testdir
    prefix/"test"
  end

  def install

    #mv "texk/web2c/pdftexdir/pdftoepdf-newpoppler.cc", "texk/web2c/pdftexdir/pdftoepdf.cc"
    #mv "texk/web2c/pdftexdir/pdftosrc-newpoppler.cc",  "texk/web2c/pdftexdir/pdftosrc.cc"

    # Configure and build out-of-tree, as recommended by the TeX Live folks.
    mkdir "work" do
      # Configure.
      system "../configure",
        #"--with-banner-add='- spl/tex/texlive-minimal'",
        "--disable-dependency-tracking",  # Speed up
        "--disable-silent-rules",         # Speed up
        "--disable-native-texlive-build", # For platform distributions
        "--disable-static",               # No statically linked executables
        "--enable-shared",                # Use shared libraries
        "--without-x",                    # Disable X Windows
        "--disable-dvisvgm",              # Formula: spl/tex/dvisvgm
        "--prefix=#{prefix}",
        "--bindir=#{bin}",
        "--datarootdir=#{prefix}",
        "--includedir=#{include}",
        "--infodir=#{info}",
        "--libdir=#{lib}",
        "--mandir=#{man}"

      # Build.
      system "make"

      # Install (and strip binaries)
      system "make", build.with?("strip") ? "install-strip" : "install"

      # Run 'texlinks' the first time.
      system "make", "texlinks"

      # Test build.
      system "make", "check" if build.with? "test"
    end

    # Install missing updmap entries for the standard PostScript fonts.
    resource("texmf-dist/fonts/map/dvips/tetex").stage prefix/"texmf-dist/fonts/map/dvips"

    # Install missing epstopdf files.
    resource("epstopdf").stage do
      # Install man pages.
      man1.install Dir["*.1"]
      # Install test file.
      (testdir/"epstopdf").install "test-simple.eps"
    end

    # Install mktexlsr.pl, which is required by fmtutil.pl but not included.
    resource("mktexlsr.pl").stage prefix/"texmf-dist/scripts/texlive"

    # Install the Perl modules TLConfig.pm and TLUtils.pm used by fmtutil.pl,
    # tlmgr.pl, and updmap.pl.
    (prefix/"tlpkg").install "texk/tests/TeXLive"

    # Install test files.
    (testdir/"dvips").install "texk/dvipsk/testdata/eepic-nan.dvi"
    (testdir/"ps2pk").install Dir["texk/ps2pk/tests/{Symbol.afm,Symbol.pfb,Symbol10.300pk}"]
    (testdir/"dvipng").install "texk/dvipng/dvipng-src/test_dvipng.tex"
  end

  def post_install
    # Rebuild the ls-R filename databases.
    system "mktexlsr"

    # Rebuild the TeX formats and Metafont bases. Exit with success.
    system "fmtutil-sys", "--all", "--no-strict"

    # Update the default font map files.
    system "updmap-sys"

    # Generate the ConTeXt file database.
    system "mtxrun", "--generate"
  end

  test do
    # kpathsea: Find its configuration file with success.
    system bin/"kpsewhich", "texmf.cnf"

    # dvips: Process a file with success.
    system bin/"dvips", testdir/"dvips/eepic-nan.dvi"

    # epstopdf: Process files with success.
    system bin/"epstopdf", testdir/"epstopdf/test-simple.eps", "--outfile=test-simple.pdf"
    system bin/"repstopdf", testdir/"epstopdf/test-simple.eps", "--outfile=test-simple.pdf"

    # ps2pk: Convert a PFB to the expected PK.
    system bin/"ps2pk", testdir/"ps2pk/Symbol.pfb"
    assert compare_file testpath/"Symbol10.300pk", testdir/"ps2pk/Symbol10.300pk"

    # dvinpng: Process a file with success.
    system bin/"latex", testdir/"dvipng/test_dvipng.tex"
    system bin/"dvipng", "-T", "tight", "-strict", "test_dvipng"
  end

end

__END__
diff --git a/texk/kpathsea/texmf.cnf b/texk/kpathsea/texmf.cnf
--- a/texk/kpathsea/texmf.cnf
+++ b/texk/kpathsea/texmf.cnf
@@ -58,7 +58,7 @@
 % SELFAUTOPARENT (its grandparent = /usr/local/texlive/YYYY), and
 % SELFAUTOGRANDPARENT (its great-grandparent = /usr/local/texlive).
 % Sorry for the off-by-one-generation names.
-TEXMFROOT = $SELFAUTOPARENT
+TEXMFROOT = $SELFAUTODIR
 
 % The main tree of distributed packages and programs:
 TEXMFDIST = $TEXMFROOT/texmf-dist
@@ -68,13 +68,13 @@ TEXMFDIST = $TEXMFROOT/texmf-dist
 TEXMFMAIN = $TEXMFDIST
 
 % Local additions to the distribution trees.
-TEXMFLOCAL = $SELFAUTOGRANDPARENT/texmf-local
+TEXMFLOCAL = HOMEBREW_PREFIX/share/texmf-local
 
 % TEXMFSYSVAR, where *-sys store cached runtime data.
-TEXMFSYSVAR = $TEXMFROOT/texmf-var
+TEXMFSYSVAR = HOMEBREW_PREFIX/var/texmf
 
 % TEXMFSYSCONFIG, where *-sys store configuration data.
-TEXMFSYSCONFIG = $TEXMFROOT/texmf-config
+TEXMFSYSCONFIG = HOMEBREW_PREFIX/etc/texmf
 
 % Per-user texmf tree(s) -- organized per the TDS, as usual.  To define
 % more than one per-user tree, set this to a list of directories in
@@ -511,36 +511,37 @@ RUBYINPUTS   = .;$TEXMF/scripts/{$progname,$engine,}/ruby//
 % since we don't want to scatter ../'s throughout the value.  Hence we
 % explicitly list every directory.  Arguably more understandable anyway.
 %
-TEXMFCNF = {\
-$SELFAUTOLOC,\
-$SELFAUTOLOC/share/texmf-local/web2c,\
-$SELFAUTOLOC/share/texmf-dist/web2c,\
-$SELFAUTOLOC/share/texmf/web2c,\
-$SELFAUTOLOC/texmf-local/web2c,\
-$SELFAUTOLOC/texmf-dist/web2c,\
-$SELFAUTOLOC/texmf/web2c,\
-\
-$SELFAUTODIR,\
-$SELFAUTODIR/share/texmf-local/web2c,\
-$SELFAUTODIR/share/texmf-dist/web2c,\
-$SELFAUTODIR/share/texmf/web2c,\
-$SELFAUTODIR/texmf-local/web2c,\
-$SELFAUTODIR/texmf-dist/web2c,\
-$SELFAUTODIR/texmf/web2c,\
-\
-$SELFAUTOGRANDPARENT/texmf-local/web2c,\
-$SELFAUTOPARENT,\
-\
-$SELFAUTOPARENT/share/texmf-local/web2c,\
-$SELFAUTOPARENT/share/texmf-dist/web2c,\
-$SELFAUTOPARENT/share/texmf/web2c,\
-$SELFAUTOPARENT/texmf-local/web2c,\
-$SELFAUTOPARENT/texmf-dist/web2c,\
-$SELFAUTOPARENT/texmf/web2c\
-}
+%TEXMFCNF = {\
+%$SELFAUTOLOC,\
+%$SELFAUTOLOC/share/texmf-local/web2c,\
+%$SELFAUTOLOC/share/texmf-dist/web2c,\
+%$SELFAUTOLOC/share/texmf/web2c,\
+%$SELFAUTOLOC/texmf-local/web2c,\
+%$SELFAUTOLOC/texmf-dist/web2c,\
+%$SELFAUTOLOC/texmf/web2c,\
+%\
+%$SELFAUTODIR,\
+%$SELFAUTODIR/share/texmf-local/web2c,\
+%$SELFAUTODIR/share/texmf-dist/web2c,\
+%$SELFAUTODIR/share/texmf/web2c,\
+%$SELFAUTODIR/texmf-local/web2c,\
+%$SELFAUTODIR/texmf-dist/web2c,\
+%$SELFAUTODIR/texmf/web2c,\
+%\
+%$SELFAUTOGRANDPARENT/texmf-local/web2c,\
+%$SELFAUTOPARENT,\
+%\
+%$SELFAUTOPARENT/share/texmf-local/web2c,\
+%$SELFAUTOPARENT/share/texmf-dist/web2c,\
+%$SELFAUTOPARENT/share/texmf/web2c,\
+%$SELFAUTOPARENT/texmf-local/web2c,\
+%$SELFAUTOPARENT/texmf-dist/web2c,\
+%$SELFAUTOPARENT/texmf/web2c\
+%}
 %
 % For reference, here is the old brace-using definition:
 %TEXMFCNF = {$SELFAUTOLOC,$SELFAUTODIR,$SELFAUTOPARENT}{,{/share,}/texmf{-local,}/web2c}
+TEXMFCNF = HOMEBREW_PREFIX/share/texmf-local/web2c;$SELFAUTODIR/texmf-dist/web2c
 
 % kpathsea 3.5.3 and later sets these at runtime. To avoid empty
 % expansions from binaries linked against an earlier version of the
