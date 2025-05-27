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
2. Run `make test` to pass all the regession tests
3. Check that you have included the media files necessary to test your patch

Upgrade the Pandoc version
-------------------------------------------------------------------------------

1. Check for the latest release of Pandoc here: https://github.com/jgm/pandoc/releases
2. Check for the latest release of the pandoc/extra image here: https://hub.docker.com/r/pandoc/extra
3. Modify the image tag in `Dockerfile`

Handling your personal data
-------------------------------------------------------------------------------

If you submit a patch to this project, the name and the email address you give
us may be embedded in the public repository. The removal of this information
would break the code history and would be impermissibly destructive to the
project and the interests of all those who contribute or benefit from it.

As an open source project, we consider that we must maintain this information
in the repository for archiving purposes in the public interest.

How To Release a new version
-------------------------------------------------------------------------------

Let's say you want to release version `23.07`

* [ ] Close all open ticket on the current milestone
* [ ] Create a `release` branch
* [ ] Update the [CHANGELOG.md]()
* [ ] Add `23.07` in `on.push.branches` in [.github/workflows/docker_hub.yml]()
* [ ] Write a announcement in [NEWS.md]()
* [ ] Merge the `release` branch into `latest`
* [ ] Add a tag `23.07` to `latest`
* [ ] Create a new [release]
* [ ] Rebase the `stable` branch from `latest`
* [ ] Create a `23.07` branch from `latest`
* [ ] Check that github Actions is correctly publishing the images
* [ ] Create the next milestone
* [ ] Bump the new version on `latest`
* [ ] Publish the announcement
* [ ] Bump to the new version in [CHANGELOG.md]()
* [ ] Close the current milestone

[release]: https://github.com/dalibo/pandocker/releases
