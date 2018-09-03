Changelog
===============================================================================

18.08
------------------------------------------------------------------------------- 

__Stack__
* Debian 9 stretch
* Pandoc 2.1


__Changes__

* FIX #53 : Broken CI (daamien)
* Only log pandoc command (bersace)
* [doc] do not run pandoc as root  (Eric Lemoine)
* Add Libration Font (daamien)


<https://github.com/dalibo/pandocker/milestone/4>

18.06 [dd467072547ec323f3801f4fc135a05a6e530542]
-------------------------------------------------------------------------------

__Stack__

* Debian 9 stretch
* Pandoc 2.1

__Changes__

* Support for German characters (daamien + Thanks to Michael Mayer)
* Add a Contributing file (daamien)


<https://github.com/dalibo/pandocker/milestone/3>

18.03 [2b303b2200e0d9beb3b16f18784ddb370c97088b]
-------------------------------------------------------------------------------

__Stack__

* Debian 9 stretch
* Pandoc 2.1

__Changes__

* Switch to pandoc 2.1 (bersace)
* Major Reduction : image size is now 262 MB (bersace)
* Drop pandoc-latex-tip (bersace)
* Add pandoc-minted and pygments (julmon)
* Local cache for docker build (bersace)
* Transfer copyright to dalibo (daamien)
* README : badges + fixes (bersace+daamien)
* Only use binary and python3 (bersace)
* Add CI job (bersace)
* Restore beamer (bersace)
* Various updates (bersace)
* Add AUTHORS (daamien)
* FIX #18 : pandoc requires a `protocols` file for the self-contained mode (daamien)
* FIX #19 : restore texlive-pstricks (daamien)
* FIX #20 : Add backward compatibility for pandoc 1.x (bersace)
* FIX #22 : Add imagemagick (daamien)
* FIX #24 : Add texlive_luatex to restore ucharcat  (daamien)
* FIX #26 : [doc] Explain how to install the toolchain without docker (daamien)
* FIX #36 : the pandoc.sh wrapper introduces unnecessary quotes (daamien)

<https://github.com/dalibo/pandocker/milestone/2>



17.12 [1ac416c98189759fe5a3978c8e8ae4b6aaeda24e]
-------------------------------------------------------------------------------
__Stack__

  * Debian 9 stretch
  * Pandoc 1.19.2

__Changes__
  * Switch to Stretch
  * Add pandoc-dalibo-guidelines
  * Abandonned wkhtml2pdf

<https://github.com/dalibo/pandocker/milestone/1>


17.09 [96dbd315b103501d10f468becad05a0094159a4e]
-------------------------------------------------------------------------------

__Stack__

  * Debian 8 Jessie
  * Pandoc 1.19.2
  * wkhtmltopdf : 0.12.4

__Changes__
  * Add pandoc-latex-levelup
  * doc

17.06 [ce920cd8c8855d07592f65f0a04b74cbdf7d1c51]
-------------------------------------------------------------------------------

__Stack__

  * Debian 8 Jessie
  * Pandoc 1.19.2
  * wkhtmltopdf : 0.12.4

__Changes__

  * New Filter : pandoc-latex-admonition
  * Install Python3 for panflute
  * Additional Python module : pypdf2
  * gna.org is down : change source for wkhtmltopdf
  * Add poppler-utils for PDF meta analysis
  * Change source URL for wkhtmltopdf
  * Add rsync and ssh-agent

17.03 : [0626d14f3fc4a2ae9855aa71d082498063fbe40b]
-------------------------------------------------------------------------------

__Stack__

  * Debian 8 Jessie
  * Pandoc 1.19.1


__Changes__ : : Jessie + pandoc

* Add some Pandoc filters
* Add Lato font
* Switch to latest Pandoc version
* FIX wkhtmltopdf path


16.12 : Init [ad4923b213b8929303a7d3bc4af58930ca4d1e27]
-------------------------------------------------------------------------------

* Proof of Concept
