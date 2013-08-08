## Angular Cucumber Example

This is a working example of running Angular E2E tests using [Cucumber.js](https://github.com/cucumber/cucumber-js), [Protractor](https://github.com/angular/protractor), and [WebDriverJS](https://code.google.com/p/selenium/wiki/WebDriverJs).

### Getting Started

1. Install dependencies

        npm install
        bower install

2. Start the application server

        grunt server

### Running Tests

1. Start the application server

        grunt server

2. Start the selenium server

        grunt selenium

3. Run the cucumber tests

        grunt test

### Resources

- [Cucumber.js README](https://github.com/cucumber/cucumber-js)
- [Protractor README](https://github.com/angular/protractor)
- [WebDriverJS Guide](https://code.google.com/p/selenium/wiki/WebDriverJs)
- [WebDriverJS WebDriver API](https://code.google.com/p/selenium/source/browse/javascript/webdriver/webdriver.js)
- [WebDriverJS Locators API](https://code.google.com/p/selenium/source/browse/javascript/webdriver/locators.js)

### TODO

- Quit driver after running all the cucumber tests. Can easily be added once the [afterAll hook is added to cucumber.js](https://github.com/cucumber/cucumber-js/issues/97)
- Invoke a callback after `ptor.get` so that visiting a page can be a cucumber step. This seems to require changes in protractor so that `ptor.get` returns a promise, which selenium-webdriver's `webdriver.get` already does. I've submitted a [pull request](https://github.com/angular/protractor/pull/45).

### Questions

These are questions that I need to figure out due to my lack of familiarity with WebDriverJS and Selenium.

- Why does omitting `usingServer` allow running tests on Chrome without having the selenium server running?
- Saving `world.coffee` triggers some actions on the selenium server. Assuming there is some file watching mechanism in place, what files are watched and which actions are taken?
