module.exports = ->

  @Given /^my name is "([^"]+)"$/, (name, next) ->
    @me or= @Factory('Me')
    @me.first_name = name.split(' ')[0]
    @me.last_name  = name.split(' ')[1]
    next()

  @Given /^I live in "([^"]+), ([^"]+)"$/, (city, state, next) ->
    @me or= @Factory('Me')
    @me.residence_city  = city
    @me.residence_state = state
    next()

  @Given /^I am supporting the "([^"]+)" charity$/, (charity, next) ->
    @me or= @Factory('Me')
    @me.charity = charity
    next()

  @Given /^I have set my avatar to "([^"]+)"$/, (url, next) ->
    @me or= @Factory('Me')
    @me.profile_photo_url = url
    next()

  @Given /^I have earned (\d+) stars$/, (count, next) ->
    @me or= @Factory('Me')
    @me.stars_count = count
    next()

  @Given /^I have earned (\d+) top awards$/, (count, next) ->
    @me or= @Factory('Me')
    @me.top_awards_count = count
    next()

  @Given /^I have (\d+) top 100 finishes$/, (count, next) ->
    @me or= @Factory('Me')
    @me.top_finish_count = count
    next()
