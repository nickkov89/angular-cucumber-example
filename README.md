## Angular Cucumber Example

This is a working example of running Angular E2E tests using Cucumber, Protractor, and WebDriverJS.

### Getting Started

1. Install dependencies

        npm install
        bower install

2. Start the server

        grunt server

### Running Tests

1. Start the selenium server

        java -jar selenium/selenium-server-standalone-2.33.0.jar -Dwebdriver.chrome.driver=./selenium/chromedriver

2. Run the cucumber tests

        grunt test

### Resources

- [Protractor README](https://github.com/angular/protractor)
- [WebDriverJS Guide](https://code.google.com/p/selenium/wiki/WebDriverJs)
- [WebDriverJS WebDriver API](https://code.google.com/p/selenium/source/browse/javascript/webdriver/webdriver.js)
- [WebDriverJS Locators API](https://code.google.com/p/selenium/source/browse/javascript/webdriver/locators.js)

### TODO

- Quit driver after running all the cucumber tests. Can easily be added once the [afterAll hook is added to cucumber.js](https://github.com/cucumber/cucumber-js/issues/97)
- Start the selenium server on the Grunt task
- Invoke a callback after `ptor.get` so that visiting a page can be a cucumber step. This seems to require changes in protractor so that `ptor.get` returns a promise, which selenium-webdriver's `webdriver.get` already does.
