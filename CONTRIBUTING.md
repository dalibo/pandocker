# How To Contribute

Thanks for your interest to this docker image !


How To Submit a Bug
-------------------------------------------------------------------------------

If you're facing a bug when compiling a document, please do the following
before submitting an issue:

* Fetch the latest version with ``docker pull dalibo/pandocker:latest``
  and check if the error remains.

* Read the [SYNTAX](SYNTAX.md) specs and check that you used the correct
  markdown syntax


How To Submit a Patch
-------------------------------------------------------------------------------

1. Run `make all` locally to build your modifications before submitting

2. Check that you have included the media files necessary to test your patch

Upgrade the Pandoc version
-------------------------------------------------------------------------------

1. Modify the `PANDOC_VERSION` variable in the [Makefile](Makefile)
2. Modify the `PANDOC_VERSION` variable in the [Dockerfile](Dockerfile)
3. If needed modify the `PANDOC_CROSSREF_VERSION` likewise

Handling your personal data
-------------------------------------------------------------------------------

If you submit a patch to this project, the name and the email address you give
us may be embedded in the public repository. The removal of this information
would break the code history and would be impermissibly destructive to the
project and the interests of all those who contribute or benefit from it.

As an open source project, we consider that we must maintain this information
in the repository for archiving purposes in the public interest.

