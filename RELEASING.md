# How To Release a new version

* [ ] Close all open ticket on the current milestone
* [ ] Create a `release` branch
* [ ] Update the [CHANGELOG.md]()
* [ ] Write a announcement in [NEWS.md]()
* [ ] Merge the `release` branch into `latest`
* [ ] Add a tag to `latest`
* [ ] Create a new [release]
* [ ] Rebase the `stable` branche from `latest`
* [ ] Wait for docker hub to rebuild the images
* [ ] Create the next milestone
* [ ] Bump the new version on `latest`
* [ ] Publish the announcement
* [ ] Bump to the new version in [CHANGELOG.md]()
* [ ] Close the current milestone

[release]: https://github.com/dalibo/pandocker/releases
