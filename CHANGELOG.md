Changelog
===============================================================================

21.09
-------------------------------------------------------------------------------

__Stack__

* Debian 10 buster
* Pandoc 2.14
* Eisvogel 2.0

__Changes__

<https://github.com/dalibo/pandocker/milestone/12>

* [extra] Upgrade to pandoc 2.14
* [filters] Upgrade pandoc-latex-admonition
* [CI] check for pandoc-crossref version mismatch
* [extra] embed revealjs 4.1.2 for offline builds
* [extra] add awesomebox + fontawesome
* [extra] Adds librsvg to alpine and buster containers (@colindean)
* [filters] Bump pygments from 2.4 to 2.7.4
* [extra] Add support for Spanish (@iapellaniz)


21.02
-------------------------------------------------------------------------------

__Stack__

* Debian 10 buster
* Pandoc 2.11
* Eisvogel 2.0

__Changes__

<https://github.com/dalibo/pandocker/milestone/11>

* Upgrade to debian buster
* Upgrade to pandoc 2.11
* Upgrade to eisvogel 2.0
* Add an experimental alpine variant based on `pandoc:latex`
* Create a `latest-buster-full` tag for huge packages
* Archive the debian stretch version
* [full] Add support for Hindi ( Sponsored by OWASP Foundation )
* [full] Add support for Persian ( Sponsored by OWASP Foundation )
* [full] restore Noto Font
* [filters] `pandoc-citeproc` is now obsolete, use `--citeproc` instead
* [fonts] Add fontawesome5 to allow awesomebox to work (@vvishnyakov)
* Add support for Spanish in latex (@iapellaniz)
* Remove pandoc 1.x compatibility
* Disable Circle CI

20.02
-------------------------------------------------------------------------------


__Stack__

* Debian 9 stretch
* Pandoc 2.9
* Eisvogel 1.4.0

__Changes__

<https://github.com/dalibo/pandocker/milestone/10>

* Switch to Pandoc 2.9 (daamien)
* Switch to Eisvogel 1.4 (daamien)
* [filters] add pandoc-crossref (colindean)
* [doc] using pipes to produce a pdf file (daamien)
* [doc] the pandoc-citeproc is already installed (daamien)
* [lang] add dutch and all european languages (DigitalTravelDuck)
* [templates] add leaflet template (daamien)
* [templates] add Letter Template (daamien)
* [CI] use bats-core for testing (daamien)
* [CI] remove useless submodules (daamien)
* [CI] remove the fixtures folder (daamien)
* [fonts] add deja-vu and noto (daamien)
* [dev] the default branch is not called `latest`  (daamien)
* [dev] the `master` branch is obsolete  (daamien)
* [doc] using pipes to generate pdf files (daamien)
* [doc] explaining the `docker run` options (daamien)


19.11
-------------------------------------------------------------------------------

__Stack__
* Debian 9 stretch
* Pandoc 2.7.3
* Eisvogel 1.3.0

__Changes__

<https://github.com/dalibo/pandocker/milestone/9>

* Switch to Pandoc 2.7.3 (colindean)
* Switch to Eisvogel 1.3 (daamien)
* [doc] FAQ
* [CI] enable Github Actions


19.08
-------------------------------------------------------------------------------

__Stack__
* Debian 9 stretch
* Pandoc 2.7

__Changes__

* Freeze pip versions (daamien)
* Add pandoc-codeblock-include filter (daamien)
* Add dia (daamien)

<https://github.com/dalibo/pandocker/milestone/8>

19.05
-------------------------------------------------------------------------------

__Stack__
* Debian 9 stretch
* Pandoc 2.7

__Changes__

* Switch to pandoc 2.7  (daamien)
* FIX #87 Error in .ssh/config ( bersace + misamura)
* Add include filter (misamura)


<https://github.com/dalibo/pandocker/milestone/7>


19.02
-------------------------------------------------------------------------------

__Stack__
* Debian 9 stretch
* Pandoc 2.6

__Changes__

* Switch to pandoc 2.6  (daamien)
* Add emojis support for PDF (daamien + liloumuloup)
* Add more CI tests (daamien)
* Add support for mustache template syntax with `pandoc-mustache` (daamien + madtibo)

<https://github.com/dalibo/pandocker/milestone/6>



18.11 [a819f9abb4609cd764882e9898993556f9a1fc4c]
-------------------------------------------------------------------------------

__Stack__
* Debian 9 stretch
* Pandoc 2.3


__Changes__

* Switch to pandoc 2.3  (daamien)
* Disable Pandoc1 compatibility by default (daamien)
* Add Eisvogel template  (daamien)
* Add a weasy print container for testing purpose  (daamien)


<https://github.com/dalibo/pandocker/milestone/5>


18.08 [3a5e13cb74ee837b995146eaa4d0da3d05e87acd]
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
