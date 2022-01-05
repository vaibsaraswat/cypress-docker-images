# Contributing to Cypress

Thanks for taking the time to contribute! :smile:

## Code of Conduct

All contributors are expecting to abide by our [Code of Conduct](https://github.com/cypress-io/cypress/blob/develop/CODE_OF_CONDUCT.md).

## Development

### Replacing existing images

⚠️ As a rule, unless there are extraordinary circumstances, we do NOT replace the existing Docker images. Replacing the images already used by people is dangerous, since it replaces the versions of tools without warning. We have such failed experience once, and do not want to repeat this mistake. Thus instead of replacing an existing image, in 99% of the cases we publish a new Docker image.

### Add new base image

To create a new base image follow these steps

1. run `npm run add:base -- <new version>` script. For example `npm run add:base -- 13.6.0`

This script will create a new folder in `base/<new version>` and output versions of tools installed: Node, npm, yarn, etc. See [generate-base-image.js](generate-base-image.js) file for details.

2. add new line to [base/README.md](base/README.md) with new image information.
3. add new folder to Git
4. update [circle.yml](circle.yml) file by running `npm run build` and commit the changes.
5. open a pull request.

The new image will be built and tested on CI and pushed to Docker Hub once the PR is approved and merged to `master`.

**note:** we should install the latest NPM and Yarn versions in the base image to ensure old images do not include NPM and Yarn with known issues that have been fixed already.

**note 2:** we install Chinese fonts in the base image to allow correct testing of [cypress-documentation](https://github.com/cypress-io/cypress-documentation) site that includes several translations of the Cypress docs. Without Chinese fonts the pages have broken rendering.

### Add new image with browsers

TODO: https://github.com/cypress-io/cypress-docker-images/issues/215

**Important:** prefer to use exact browser versions for repeatable builds. You can find the previous official Chrome version numbers at [https://chromereleases.googleblog.com/](https://chromereleases.googleblog.com/).

**Important:** use `https:` to download browsers

### Add new included image

To create a new image with Cypress pre-installed globally

1. run `npm run add:included -- <Cypress version> <base image tag>`. For example `npm run add:included -- 3.8.3 cypress/browsers:node12.6.0-chrome77`.

**important ⚠️** please use `cypress/browsers` Docker image with the Node version that **matches** the Node version bundled inside Cypress you are about to install there.

This will create new folder `included/<Cypress version>`

2. add new line to [included/README.md](included/README.md) file with the new image information
3. add new folder to Git
4. update [circle.yml](circle.yml) file by running `npm run build` and commit the changes.
5. open a pull request.

## Tagging the latest image

We build individual base images that match Node versions: `10.18.1`, `12.12.0`, `12.18.2`, etc. We also tag some of the images with major version: `base:10`, `base:12`. We also tag one image `base:latest`. In general, you should use the explicit version like `base:12.18.0` because it guarantees that the Docker image will never be suddenly updated.

To tag new image, like `base:12.18.2` need to do the following from a local machine

```text
# pull the image to tag
$ docker pull cypress/base:12.18.2

# tag that image with major version
$ docker tag cypress/base:12.18.2 cypress/base:12

# or you can tag that image with "latest"
$ docker tag cypress/base:12.18.2 cypress/base:latest

# push the new images (which are the same)
$ docker push cypress/base:12
$ docker push cypress/base:latest
```

### Commit Message Guidelines

We have guidelines around how commit messages should look. This leads to _more readable messages_ that are easy to follow when looking through the _project history_.

#### Format

Each commmit message should consist of a _header_, a _body_, and a _footer_. The header should have a specific format that includes a _type_, a _scope_ and a _subject_:

```bash
<type>(<scope>): <subject>
<BLANK LINE>
<body>
<BLANK LINE>
<footer>
```

#### Type

Must be one of the following: -_build_: Changes that affect the build system or external dependencies -_ci_: Changes to our CI configuration files and scripts -_docs_: Documentation only changes -_feat_: A new feature -_fix_: A bug fix -_ref_: A code change that neither fixes a bug nor adds a feature -_test_: Adding missing tests or correcting existing tests

#### Scope

The scope is optional and should be the name of the type of image that was created or affected -_base_ -_browsers_ -_included_

#### Subject

The subject contains a succinct descript of the change that should _not_ end in a `period (.)` or should _not_ begin with a capitalized letter

#### Body

The body should include the motivation for the change and constrast this with the previous behavior

#### Footer

The footer should contain a closing reference to an issue. `ie: Closes #1234`
