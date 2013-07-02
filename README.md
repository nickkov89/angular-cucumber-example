![PORTAL](http://i.imgur.com/gRhBIt8.jpg)

---

## Crowdtap Portal

_Hello, and welcome to the Crowdtap Brands Computer-Aided Enrichment Center._

### Getting started

Clone the repo and fire up your Portal:

* `npm install` to install all dependencies.
* `coffee server.coffee` to run the server on `localhost:9295`.

__NOTE:__ If you can't seem to find `coffee` or any other npm module, you can find them under `node_modules/.bin/` under an application's root directory. You may want to add that to your `PATH`.

### Running tests

* Run the entire test suite: `npm test`
* Run features only: `npm run-script cucumber`
* Run specs only: `npm run-script spec`

__NOTE:__ You can find all of the available scripts in `package.json` under the `scripts` key.

### Assets

CSS is organized as per our [styleguide](https://github.com/crowdtap/wiki/blob/master/pages/CSS_STYLEGUIDE.md) under `css/`.
JavaScript libraries should be installed as npm modules, or if unavailable as a module, it should be copied into `public/` and added to `slug.json`.
All other app-specific assets live in `public/crowdtap.portal/` as per our convention.

#### Shared assets

Shared assets are installed automatically after running `npm install`. You can update shared assets manually with `node_modules/.bin/parachute install --update`. To see a manifest of the shared assets, see [parachute.json](https://github.com/crowdtap/assets.shared/blob/master/parachute.json).

For complete details on how shared assets works, see [assets.shared](https://github.com/crowdtap/assets.shared) and [parachute](https://github.com/crowdtap/parachute).
