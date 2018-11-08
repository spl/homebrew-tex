class TexliveScripts < Formula
  desc "TeX Live scripts: fmtutil, updmap, texconfig, and many more"
  homepage "https://tug.org/texlive/scripts-sys-user.html"
  # A local mirror but not a permanent URL. Try it first.
  url "http://mirror.ctan.org/systems/texlive/Source/texlive-20180414-source.tar.xz"
  # Not a local mirror but is a permanent URL. Try it second.
  mirror "ftp://tug.org/historic/systems/texlive/2018/texlive-20180414-source.tar.xz"
  sha256 "fe0036d5f66708ad973cdc4e413c0bb9ee2385224481f7b0fb229700a0891e4e"
  version "20180414"

  depends_on "spl/tex/kpathsea"

  def install
    # Configuring and building in-tree is discouraged by the TeX Live folks.
    # So, we create a work directory and do our things there.
    workdir = buildpath/"work"
    workdir.mkpath

    chdir workdir do
      # Configure.
      system buildpath/"texk/texlive/configure",
        "--disable-dependency-tracking",
        "--disable-silent-rules",
        "--mandir=#{man}",
        "--datarootdir=#{libexec}",
        "--prefix=#{prefix}"

      # 'make install' does not create these paths but does require them.
      [bin, man1, man5, libexec].each(&:mkpath)

      # Install.
      system "make", "install"

      # Remove scripts provided by other formulae.
      rm_rf Dir[libexec/"texmf-dist/scripts/{epstopdf,latexdiff,latexmk}"]
      rm_f Dir[bin/"{epstopdf,repstopdf,latexdiff,latexdiff-vc,latexrevise,latexmk}"]

      # Install only these directories in share/../texmf-dist. Leave
      # texmf-dist/scripts where it is because of the symlinks in bin.
      (pkgshare/"texmf-dist").install Dir[libexec/"texmf-dist/{web2c,texconfig}"]
    end
  end

end
