require '../spec_helper'
Me = require("#{process.cwd()}/app/models/me")

describe 'Me', ->
  it 'has the right api path', ->
    expect(Me.url).toEqual('/api/v2/me')

  it 'has the right api path for instances', ->
    me = new Me({id: 1})
    expect(me.url()).toEqual('/api/v2/me')
