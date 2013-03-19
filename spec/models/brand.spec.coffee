require '../spec_helper'
Brand = require("#{process.cwd()}/app/models/brand")

describe 'Brand', ->
  it 'has the right api path', ->
    expect(Brand.url).toEqual('/api/v2/brands')
