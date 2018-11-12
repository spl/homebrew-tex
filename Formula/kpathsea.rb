# Resources:
# * Gentoo: https://gitweb.gentoo.org/repo/gentoo.git/tree/dev-libs/kpathsea

class Kpathsea < Formula
  desc "Path searching library and tools for TeX-related files"
  homepage "https://tug.org/kpathsea/"
  # A local mirror but not a permanent URL. Try it first.
  url "http://mirror.ctan.org/systems/texlive/Source/texlive-20180414-source.tar.xz"
  # Not a local mirror but is a permanent URL. Try it second.
  mirror "ftp://tug.org/historic/systems/texlive/2018/texlive-20180414-source.tar.xz"
  sha256 "fe0036d5f66708ad973cdc4e413c0bb9ee2385224481f7b0fb229700a0891e4e"
  version "6.3.0" # from c-auto.in

  # texmf.cnf contains search paths and directories used by kpathsea. We patch
  # these to fit the Homebrew directory structure.
  patch :DATA

  def install
    chdir "texk/kpathsea" do
      # SELFAUTOLOC is a variable defined by kpathsea that tells a binary using
      # kpathsea (e.g. dvips, xdvi, dvisvgm, etc.) the location of that binary.
      # Since Homebrew installs formulae into unique directories and does not
      # follow the TeX Directory Structure (TDS), we set SELFAUTOLOC to the the
      # location of the installed symlink rather than the actual binary path.
      #
      # Sources:
      #   * https://tobywf.com/2017/04/build-dvisvgm-kpathsea-on-macos/
      #   * https://gist.github.com/tobywf/aeeeee63053aaaa841b4032963406684
      inreplace "progname.c",
        /kpathsea_selfdir *\(kpse, *kpse->invocation_name\)/,
        "xstrdup (\"#{HOMEBREW_PREFIX}/bin\")"

      # Configure. See <texlive-source>/texk/kpathsea/ac/*.ac for defaults.
      system "./configure",
        "--disable-dependency-tracking",
        "--disable-silent-rules",
        "--enable-shared",
        "--disable-static",
        "--prefix=#{prefix}"

      # Build and install.
      system "make", "install"

      # This path is required for post_install.
      pkgshare.install share/"texmf-dist"
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
  end

  def caveats; <<~EOS
    This formula creates a shared directory for use by all dependent formulae.
    After uninstalling kpathsea, this directory is no longer needed, and you may
    wish to remove it:

      rm -rf #{texmf_dist}

  EOS
  end

  test do
    # This test passes if kpathsea knows how to find the configuration file,
    # which is a minimum for every binary built with kpathsea.
    system bin/"kpsewhich", "texmf.cnf"
  end
end

# The following documentation describes the patch below.
#
# TEXMFROOT is the root directory for a TeXLive distribution (assuming TDS).
# TEXMFROOT includes the distribution directory TEXMFDIST (which is correct in
# texmf.cnf) and the directory for local additions TEXMFLOCAL (which is left for
# users and explicitly not used by Homebrew).
#
# TEXMFROOT is so-named because it is the root of a portable TeX Live
# distribution. However, we use a directory hierarchy specifically for Homebrew,
# which is not portable.
#
# TEXMFDIST is reserved for distribution configuration files. It is use by
# Homebrew formula and should not be changed by users. The default value is
# good: $TEXMFROOT/texmf-dist
#
# TEXMFLOCAL is reserved for users. Configuration files in this directory
# override configuration files in TEXMFDIST.
#
# TEXMFSYSVAR is where *-sys store cached runtime data.
#
# TEXMFSYSCONFIG is where *-sys store configuration data.
#
# TEXMFCNF is the compile-time list of search paths for texmf.cnf. Rather than
# use all of the paths defined for a TeXLive distribution, we provide two paths:
#   - texmf-local: for user overriding
#   - kpathsea/texmf-dist: the one used by this formula

__END__
diff --git a/texk/kpathsea/texmf.cnf b/texk/kpathsea/texmf.cnf
--- a/texk/kpathsea/texmf.cnf
+++ b/texk/kpathsea/texmf.cnf
@@ -58,7 +58,7 @@
 % SELFAUTOPARENT (its grandparent = /usr/local/texlive/YYYY), and
 % SELFAUTOGRANDPARENT (its great-grandparent = /usr/local/texlive).
 % Sorry for the off-by-one-generation names.
-TEXMFROOT = $SELFAUTOPARENT
+TEXMFROOT = HOMEBREW_PREFIX/share

 % The main tree of distributed packages and programs:
 TEXMFDIST = $TEXMFROOT/texmf-dist
@@ -68,13 +68,13 @@ TEXMFDIST = $TEXMFROOT/texmf-dist
 TEXMFMAIN = $TEXMFDIST

 % Local additions to the distribution trees.
-TEXMFLOCAL = $SELFAUTOGRANDPARENT/texmf-local
+TEXMFLOCAL = $TEXMFROOT/texmf-local

 % TEXMFSYSVAR, where *-sys store cached runtime data.
-TEXMFSYSVAR = $TEXMFROOT/texmf-var
+TEXMFSYSVAR = HOMEBREW_PREFIX/var/texmf

 % TEXMFSYSCONFIG, where *-sys store configuration data.
-TEXMFSYSCONFIG = $TEXMFROOT/texmf-config
+TEXMFSYSCONFIG = HOMEBREW_PREFIX/etc/texmf

 % Per-user texmf tree(s) -- organized per the TDS, as usual.  To define
 % more than one per-user tree, set this to a list of directories in
@@ -511,33 +511,7 @@ RUBYINPUTS   = .;$TEXMF/scripts/{$progname,$engine,}/ruby//
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
+TEXMFCNF = HOMEBREW_PREFIX/share/{texmf-local/web2c,kpathsea/texmf-dist/web2c}
 %
 % For reference, here is the old brace-using definition:
 %TEXMFCNF = {$SELFAUTOLOC,$SELFAUTODIR,$SELFAUTOPARENT}{,{/share,}/texmf{-local,}/web2c}
