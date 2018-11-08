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

      # texmf.cnf contains a large number of search paths and directories used
      # by kpathsea. We adapt these to fit the Homebrew directory structure.

      inreplace "texmf.cnf" do |s|
        # TEXMFROOT is the root directory for a TeXLive distribution (assuming
        # TDS). TEXMFROOT includes the distribution directory TEXMFDIST (which
        # is correct in texmf.cnf) and the directory for local additions
        # TEXMFLOCAL (which is left for users and explicitly not used by
        # Homebrew).

        # TEXMFROOT is so-named because it is the root of a portable TeX Live
        # distribution. However, we use a directory hierarchy specifically for
        # Homebrew, which is not portable.
        s.gsub! /^(TEXMFROOT) *= *(.*)/, "\\1 = #{HOMEBREW_PREFIX}/share % was: \\2"

        # TEXMFDIST is reserved for distribution configuration files. It is use
        # by Homebrew formula and should not be changed by users. The default
        # value is good: $TEXMFROOT/texmf-dist

        # TEXMFLOCAL is reserved for users. Configuration files in this
        # directory override configuration files in TEXMFDIST.
        s.gsub! /^(TEXMFLOCAL) *= *(.*)/, "\\1 = $TEXMFROOT/texmf-local % was: \\2"

        # TEXMFSYSVAR is where *-sys store cached runtime data.
        s.gsub! /^(TEXMFSYSVAR) *= *(.*)/, "\\1 = #{var}/texmf % was: \\2"

        # TEXMFSYSCONFIG is where *-sys store configuration data.
        s.gsub! /^(TEXMFSYSCONFIG) *= *(.*)/, "\\1 = #{etc}/texmf % was: \\2"
      end

      # Configure. See <texlive-source>/texk/kpathsea/ac/*.ac for defaults.
      system "./configure",
        "--disable-dependency-tracking",
        "--disable-silent-rules",
        "--disable-multiplatform",
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
