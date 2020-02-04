# How To Release a new version

* [ ] Close all open ticket on the current milestone
* [ ] Update the [CHANGELOG.md]()
* [ ] Update the [UPGRADE.md]() procedure
* [ ] Write a announcement in [NEWS.md]()
* [ ] Add a tag to `latest`
* [ ] Rebase the `stable` and `weasy` branches from `latest`
* [ ] Wait for docker hub to rebuild the images
* [ ] Create the next milestone
* [ ] Publish the announcement
* [ ] Bump to the new version in [CHANGELOG.md]()
* [ ] Close the current milestone
