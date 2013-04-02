require '../spec_helper'
Me = require("#{process.cwd()}/app/models/me")

describe 'Me', ->
  it 'has the right api path', ->
    expect(Me.url).toEqual('/api/v2/me')

  it 'has the right api path for instances', ->
    me = new Me({id: 1})
    expect(me.url()).toEqual('/api/v2/me')

describe '#cityState', ->
  it 'returns a city and state when city is present', ->
    me = new Me({residence_city: "Seattle", residence_state: "WA"})
    expect(me.cityState()).toEqual("Seattle, WA")

  it 'returns "" when city is null', ->
    me = new Me({residence_city: null, residence_state: null})
    expect(me.cityState()).toEqual("")
