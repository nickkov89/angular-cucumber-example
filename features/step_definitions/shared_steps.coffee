should = require 'should'
path   = require 'path'

sharedSteps = module.exports = ->
  @World = require("../support/world").World

  @When /^popup windows are blocked$/, (next) ->
    @$("a[target='_blank']").click (e) ->
      e.preventDefault()
    next()

  @Then /^I should (not )?see (.+)$/, (negation, namedElement, next) ->
    selector = @selectorFor(namedElement)
    element  = @browser.query(selector)

    if negation
      should.not.exist(element, "should not have found '#{selector}'")
    else
      should.exist(element, "could not find '#{selector}'")
    next()

  @Then /^I should (not )?see "([^"]*)" within ([^:]+)$/, (negator, text, scope, next) ->
    selector = @selectorFor(scope)
    content  = @browser.text(selector)
    text     = text.replace(/\&quot;/g, '"')

    if negator
      content.should.not.include(text, "found '#{text}' within #{selector}")
    else
      content.should.include(text, "couldn't find '#{text}' within #{selector}")
    next()


  @Then /^I should see (\d+) ([^:]+)$/, (number, namedElement, next) ->
    selector = @selectorFor(namedElement)
    element = @browser.queryAll(selector)

    element.length.should.eql parseInt(number), "Number of elements with selector #{selector}"

    next()

  @Then /^(.*) should be (\d+) characters long$/, (namedElement, length, next) ->
    selector = @selectorFor(namedElement)
    element = @browser.query(selector)
    should.exist element, "couldn't locate element with selector '#{namedElement}'"

    text = @browser.text(selector)
    text.length.should.equal parseInt(length), "Expected '#{text}' to be #{length} characters long"

    next()

  @When /^I press (.*)$/, (button, next) ->
    if /^"([^"]*)"$/.test(button)
      buttonSelector = "input[value=#{button}]"
    else
      buttonSelector = @selectorFor(button)

    @browser.pressButton buttonSelector, next

  @When /^I press (.*) within (.*)$/, (button, scope, next) ->
    if /^"([^"]*)"$/.test(button)
      buttonSelector = "input[value=#{button}]"
    else
      buttonSelector = @selectorFor(button)

    @browser.pressButton "#{@selectorFor(scope)} #{buttonSelector}", next

  @When /^I click (.*)$/, (link, next) ->
    @browser.clickLink @selectorFor(link), next

  @When /^I (un)?check (.*)$/, (negation, checkbox, next) ->
    selector = if /^"([^"]*)"$/.test(checkbox) then "input[data-value=#{checkbox}]" else @selectorFor(checkbox)

    element = @browser.query(selector)

    if negation
      element.removeAttribute('checked')
    else
      element.setAttribute('checked', 'checked')

    @browser.fire 'click', element, =>
      @browser.fire 'change', element, next

  @Then /^(.*) should (not )?be checked$/, (namedElement, negation, next) ->
    selector = @selectorFor(namedElement)
    checked  = @browser.query(selector)._attributes.checked
    if negation
      should.not.exist(checked, "'#{selector}' checkbox should not have been checked")
    else
      should.exist(checked, "'#{selector}' checkbox should have been checked")

    next()

  @Then /^(.*) should be (visible|hidden)$/, (namedElement, visibility, next) ->
    selector = @selectorFor(namedElement)
    element  = @browser.query(selector)

    should.exist element, "couldn't locate element with selector '#{selector}'"

    value = element.style.display + ''
    if visibility == 'visible'
      value.should.not.eql 'none', "Expected #{selector} to be #{visibility}"
    else
      value.should.eql 'none', "Expected #{selector} to be #{visibility}"

    next()

  @When /^I attach an image to (.*) within (.*)$/, (child, parent, next) ->
    parentSelector = @selectorFor(parent)
    parentElement = @browser.query(parentSelector)
    should.exist parentElement, "couldn't locate element with selector '#{parentSelector}'"

    childSelector = @selectorFor(child)
    childElement = @browser.query(childSelector, parentElement)
    should.exist childElement, "couldn't locate element with selector '#{childSelector}' inside '#{parentSelector}'"

    imagePath = path.join process.cwd(), 'public', 'test_image.png'
    @browser.attach "#{parentSelector} #{childSelector}", imagePath, ->
      next()

  @When /^I attach a document to (.*) within (.*)$/, (child, parent, next) ->
    parentSelector = @selectorFor(parent)
    parentElement = @browser.query(parentSelector)
    should.exist parentElement, "couldn't locate element with selector '#{parentSelector}'"

    childSelector = @selectorFor(child)
    childElement = @browser.query(childSelector, parentElement)
    should.exist childElement, "couldn't locate element with selector '#{childSelector}' inside '#{parentSelector}'"

    docPath = path.join process.cwd(), 'public', 'brand_first_test.html'
    @browser.attach "#{parentSelector} #{childSelector}", docPath, ->
      next()

  @Given /^I will (confirm|deny) the "([^"]*)" prompt$/, (response, message, next) ->
    if response == "confirm"
      @browser.onconfirm(message, true)
    else
      @browser.onconfirm(message, false)

    next()

  @Then /^I should see the following steps within (.*):$/, (parent, table, next) ->
    parentSelector = @selectorFor(parent)
    parentElement = @browser.query(parentSelector)
    should.exist parentElement, "couldn't locate element with selector '#{parentSelector}'"

    counter = 0

    for step in table.hashes()
      @browser.text(".steps li:eq(#{counter})", parentElement).should.eql step.text
      counter++

    next()

  @Then /^the ([^"]+) should (not )?be marked focused$/, (selector, negator, next) ->
    element = @$("#{ @selectorFor(selector) }")
    if negator
      element.attr('class').should.not.include 'active'
    else
      element.attr('class').should.include 'active'
    next()

  @Then /^puts the hash$/, (next) ->
    console.log(@browser.location.hash)

  @Then /^the url hash should be "([^"]*)"$/, (text, next) ->
    @browser.location.hash.should.eql text, 'window hash'
    next()

  @Then /^I should see "([^"]*)" within a "([^"]*)"$/, (text, within, next) ->
    text = text.replace(/\&quot;/g, '"')
    @$("#{within}:contains('#{text}')").length.should.be.above 0, "length of #{within} containing #{text}"
    next()

  @Then /^show me the page$/, (next) ->
    @browser.wait =>
      console.log "\nBrowser Errors:", @browser.errors
      console.log @browser.html()
      @browser.viewInBrowser()

  @Then /^show me the contents of (.*)$/, (namedElement, next) ->
    @browser.wait =>
      selector   = @selectorFor(namedElement)
      htmlString = @browser.html(selector)

      if @browser.errors.length
        console.log "Errors: #{@browser.errors}"
      console.log "\nHTML Contents of '#{selector}':\n"
      console.log htmlString

    next()

  @Then /^show me any browser errors/, ( next) ->
    @browser.wait =>
      if @browser.errors.length
        console.log "Errors: #{@browser.errors}"
    next()

  @Then /^I wait (\d+) seconds?$/, (count, next) ->
    @browser.wait 1000 * parseInt(count), next

  @Then /^the tipsy tooltip should not be visible$/, (next) ->
    tipsy_element = @$(".tipsy .tipsy-w")
    tipsy_element.length.should.eql 0, "tipsy element should not be visible"
    next()

  @Then /^I should see a tipsy tooltip containing "([^"]*)"$/, (text,next) ->
    tipsy_element = @$(".tipsy")
    tipsy_element.length.should.eql 1, "tipsy element should be visible with text #{text}"
    next()

  @Then /^I should see (\d+) tipsy tooltips containing "([^"]*)"$/, (length,text,next) ->
    tipsy_elements = @$(".tipsy")
    tipsy_elements.length.should.eql parseInt(length), "tipsy element(s) should be visible with text #{text}"
    next()

  @When /^I fill in (.+) with "([^"]*)"$/, (namedElement, text, next) ->
    selector = @selectorFor(namedElement)
    element = @browser.query(selector)

    should.exist(element, "couldn't find '#{selector}'")

    @browser.fill(selector, text, next)

  @When /^I empty (.+)$/, (namedElement, next) ->
    selector = @selectorFor(namedElement)
    element = @browser.query(selector)
    should.exist(element, "couldn't find '#{selector}'")

    @browser.evaluate("$('#{selector}').html('')")
    @browser.fire('keyup', element, next)

  @Then /^(.*) should be (enabled|disabled)$/, (namedElement, state, next) ->
    selector = @selectorFor(namedElement)
    element  = @browser.query(selector)
    should.exist(element, "couldn't find '#{selector}'")

    if state == "disabled"
      Object.keys(element._attributes).should.include('disabled', "Found '#{selector}' but it was not #{state}")
    else
      Object.keys(element._attributes).should.not.include('disabled', "Found '#{selector}' but it was not #{state}")

    next()

  @Given /^an event listener exists on the "([^"]*)" element for the event "([^"]*)"$/, (element, event_name, next) ->
     element_found = @browser.query("#{element}")
     @browser.evaluate """
                       $('#{element}').append('<div class="event-listeners"></div>');
                       $('#{element}').bind('#{event_name}', function() {
                         $('#{element} .event-listeners').html('<p class="#{event_name}">poop</p>');
                       });
                       """
     next()


  @Then /^the "([^"]*)" element should have received a "([^"]*)" event$/, (element, event_name, next) ->
    event_element = @$("#{element} .event-listeners .#{event_name}")
    event_element.length.should.eql 1, "Event #{event_name} was not fired off on #{element}"
    next()

  @When /^I enter "([^"]*)" in (.*)$/, (text, namedElement, next) ->
    selector = @selectorFor(namedElement)
    element = @browser.query(selector)
    should.exist(element, "couldn't find '#{selector}'")

    @browser.fill(element, text)
    @browser.fire 'keyup', element, next

  @When /^I hover over (.*)$/, (namedElement, next) ->
    selector = @selectorFor(namedElement)
    element  = @browser.query(selector)
    should.exist(element, "couldn't find '#{selector}'")

    @browser.fire 'mouseover', element, next

  @When /^I hover off (.*)$/, (namedElement, next) ->
    selector = @selectorFor(namedElement)
    element  = @browser.query(selector)
    should.exist(element, "couldn't find '#{selector}'")

    @browser.fire 'mouseout', element, next

  @Then /^the value of (.*) should contain "([^"]*)"$/, (selector, value, next) ->
    selector = @selectorFor(selector)
    element = @browser.query(selector)

    @$(element).val().should.eql value
    next()

  @Then /^I should (not )?be on (.*)$/, (negator, pathMatcher, next) ->
    expected = @selectorFor(pathMatcher)
    actual = @browser.location._url.path
    if negator
      actual.should.not.eql expected
    else
      actual.should.eql expected
    next()

  @Then /^I select "([^"]*)" from (.+)$/, (option, namedElement, next) ->
    @browser.select(@selectorFor(namedElement), option)
    next()

  @Then /^(.*) should have a background image of "([^"]+)"$/, (selector, value, next) ->
    selector = @selectorFor(selector)
    @$(selector).css('background-image').should.eql "url(#{value})"

    next()

  @Then /^(.*) should (not )?be active$/, (namedElement, negator, next) ->
    selector = @selectorFor(namedElement)
    element  = @browser.query(selector)
    should.exist element, "couldn't find '#{selector}' within #{@browser.html()}"

    if negator
      @$(selector).attr('class').should.not.include "active"
    else
      @$(selector).attr('class').should.include "active"

    next()

   @When /^the "([^"]*)" event is triggred$/, (eventName, next) ->
     @browser.window.Spine.trigger(eventName)
     @browser.wait next
