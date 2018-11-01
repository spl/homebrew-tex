# Homebrew TeX Tap

This repository aspires to be the [Homebrew] source for all free and open-source
[TeX]-related software not already provided by other [taps] such as
[homebrew-core].

[Homebrew]: https://brew.sh
[TeX]: https://en.wikipedia.org/wiki/TeX
[taps]: https://docs.brew.sh/Taps
[homebrew-core]: https://github.com/Homebrew/homebrew-core

**Notes**

1. We say “aspires” because (a) packaging TeX software can be difficult and (b)
   there is _a lot_ of TeX software out there.
2. If it _can_ go into homebrew-core, it _should_! They have the resources to
   manage the [formulae].

[formulae]: https://formulae.brew.sh/

## Call for Help!

This project is a work in progress, so please forgive us for any problems you
run into and please help out by contributing a bug report, feature request, or
pull request.

## Background

The main source of TeX software packages is [TeX Live], which provides large,
monolithic installations for Unix, Windows, and macOS (via [MacTeX]).

[TeX Live]: https://www.tug.org/texlive/
[MacTeX]: https://www.tug.org/mactex/

There are a few problems with the TeX Live approach:

* They release only once every year, so their software versions can be quite out
  of date from the releases of the individual components.

* They install all of their files into one directory (e.g.
  `/usr/local/texlive/2018`). This has pros and cons, of course. The cons
  include having to set your `$PATH`, `$MANPATH`, etc. and non-TeX-Live software
  possibly not being able to work easily with TeX Live software.

* The installation is typically very large and does not support installing
  individual components.

## Plan

Our plan, of course, is to distribute TeX-related software differently.

**Goals**

1. Provide as many useful TeX-related formula as possible.
2. Support fine-grained package installation.
3. Source from original author where possible or TeX Live when it makes sense.

**Motivation**

1. We want to be the source for TeX-related software on macOS just as each Linux
   distribution provides its own collection of TeX-related packages. It should
   be possible for someone to `brew install` everything they need for their TeX
   rather than install MacTeX.

2. One should only have what one needs. We want to reduce the number of bytes
   downloaded, the number of bytes stored, and the number of different
   executables in the `$PATH`. We may need to make trade-offs with build time or
   other resources to satisfy this goal.

3. Authors don't always follow TeX Live's distribution schedule, and users often
   want updates more than once a year.

The current approach is to build a collection of TeX-related formulae from the
ground up. That means we start with the core dependencies and add formulae that
depend on those. We also add formulae that have no dependencies or depend only
on homebrew-core formulae.

## What's Included?

This is the current classification. As more formulae are added, it will likely
change.

**Core Libraries**

* [kpathsea](./Formula/kpathsea.rb)
* [ptexenc](./Formula/ptexenc.rb)

**Core Tools (using kpathsea)**

* [dvips](./Formula/dvips.rb)
* [ps2pk](./Formula/ps2pk.rb)

**Other**

* [teckit](./Formula/teckit.rb)
* [bibtex-perl](./Formula/bibtex-perl.rb)
* [biber](./Formula/biber.rb)
* [epstopdf](./Formula/epstopdf.rb)
* [latexmk](./Formula/latexmk.rb)

## Resources

### TeX Live

* [Building TeX Live](https://www.tug.org/texlive/doc/tlbuild.html)

### Homebrew

* [Legacy `tex-live` formula](https://github.com/Homebrew/legacy-homebrew/blob/8c24aca1889b5f15ce9d60ce7671730cf50f3ba3/Library/Formula/tex-live.rb)
* [Retired homebrew-tex tap](https://github.com/Homebrew/homebrew-tex)

### Other distributions

* MacPorts [`tex` ports] and [TeX Live portgroup]
* [Gentoo Linux](https://wiki.gentoo.org/wiki/TeX_Live)
* [ArchLinux](https://wiki.archlinux.org/index.php/TeX_Live)

[`tex` ports]: https://github.com/macports/macports-ports/tree/master/tex
[TeX Live portgroup]: https://github.com/macports/macports-ports/blob/master/_resources/port1.0/group/texlive-1.0.tcl
