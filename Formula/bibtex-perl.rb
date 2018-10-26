# This formula build a library, binaries, and Perl modules.
#
# The library and binaries need some postprocessing: see below.
#
# As for sharing the Perl modules (to avoid having to build and install them
# again), I'm not sure of the best way to do it in Homebrew. Currently, any
# downstream formulae should hardcode the path in a way similar to this:
#
#   /usr/local/Cellar/<formula-name>/<version>/libexec/lib/perl5

class BibtexPerl < Formula
  desc "Library and tools for reading, parsing, and processing BibTeX files"
  homepage "https://github.com/ambs/Text-BibTeX"
  # WARNING!
  #   If this version changes, the path in biber.rb must also change.
  url "https://cpan.metacpan.org/authors/id/A/AM/AMBS/Text-BibTeX-0.85.tar.gz"
  sha256 "1005455f09ad5d39ebf6b45c87106a7341cbe5a7b25251dd05c7c960d7ebd30c"

  depends_on "perl"

  conflicts_with "btparse", :because => "both install the same library and binaries"

  # Config::AutoConf (no dependencies)
  resource "Capture::Tiny" do
    url "https://cpan.metacpan.org/authors/id/D/DA/DAGOLDEN/Capture-Tiny-0.48.tar.gz"
    sha256 "6c23113e87bad393308c90a207013e505f659274736638d8c79bac9c67cc3e19"
  end

  # Module::Build (no dependencies)
  resource "inc::latest" do
    url "https://cpan.metacpan.org/authors/id/D/DA/DAGOLDEN/inc-latest-0.500.tar.gz"
    sha256 "daa905f363c6a748deb7c408473870563fcac79b9e3e95b26e130a4a8dc3c611"
  end

  # ExtUtils::LibBuilder
  resource "Module::Build" do
    url "https://cpan.metacpan.org/authors/id/L/LE/LEONT/Module-Build-0.4224.tar.gz"
    sha256 "a6ca15d78244a7b50fdbf27f85c85f4035aa799ce7dd018a0d98b358ef7bc782"
  end

  # Text::BibTeX
  resource "ExtUtils::LibBuilder" do
    url "https://cpan.metacpan.org/authors/id/A/AM/AMBS/ExtUtils-LibBuilder-0.08.tar.gz"
    sha256 "c51171e06de53039f0bca1d97a6471ec37941ff59e8a3d1cb170ebdd2573b5d2"
  end

  # Text::BibTeX
  resource "Config::AutoConf" do
    url "https://cpan.metacpan.org/authors/id/R/RE/REHSACK/Config-AutoConf-0.317.tar.gz"
    sha256 "01e4b22d2fecb7cfd3cc1f4dabe95cd137cf249cc5e38184f88556e5c98a9ce1"
  end

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", libexec/"lib"

    resources.each do |r|
      r.stage do
        perl_build(r.name)
      end
    end

    perl_build("Text::BibTeX")

    # install_name_tool fails during the build due to no write access. For the
    # library and each of the binaries, we make the files writeable and run it.
    # The permissions are fixed by Homebrew during the "Cleaning" stage. See
    # https://github.com/NixOS/nixpkgs/pull/35438

    oldlib = libexec/"lib/libbtparse.dylib"
    newlib = lib/"libbtparse.dylib"
    buildlib = buildpath/"btparse/src/libbtparse.dylib"

    # install_name_tool the library.
    chmod "u+w", oldlib
    system "install_name_tool", "-id", newlib, oldlib
    lib.install oldlib

    # install_name_tool the binaries.
    %w[biblex bibparse dumpnames].each do |f|
      p = libexec/"bin"/f
      chmod "u+w", p
      system "install_name_tool", "-change", buildlib, newlib, p
      (bin/f).write_env_script(p, :PERL5LIB => ENV["PERL5LIB"])
    end

    # This is a Perl script. It doesn't need install_name_tool changes.
    (bin/"config_data").write_env_script(libexec/"bin"/"config_data", :PERL5LIB => ENV["PERL5LIB"])

    man1.install Dir[libexec/"man/man1/*.1"]
    man3.install Dir[libexec/"man/man3/*.3"]
  end

  test do
    (testpath/"test.bib").write <<~EOS
      @article{mxcl09,
        title={{H}omebrew},
        author={{H}owell, {M}ax},
        journal={GitHub},
        volume={1},
        page={42},
        year={2009}
      }
    EOS

    system "#{bin}/bibparse", "-check", testpath/"test.bib"
  end

  private

  def perl_build(target)
    if File.exist? "Makefile.PL"
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make", "PERL5LIB=#{ENV["PERL5LIB"]}"
      system "make", "install"
    elsif File.exist? "Build.PL"
      system "perl", "Build.PL", "--install_base", libexec
      system "./Build", "PERL5LIB=#{ENV["PERL5LIB"]}"
      system "./Build", "install"
    else
      raise "Unknown build system for #{target}"
    end
  end

end
