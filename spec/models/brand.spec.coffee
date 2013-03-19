require '../spec_helper'
Brand = require("#{process.cwd()}/app/models/brand")

describe 'Brand', ->
  beforeEach ->
    Brand.deleteAll()

  it 'has the right api path', ->
    expect(Brand.url).toEqual('/api/v2/brands')

  describe ".myBrands", ->
    it "returns the brands of which I'm a crowd participant in", ->
      one   = Brand.create(id: 12345, crowd_participant: true)
      two   = Brand.create(id: 12346, crowd_participant: true)
      three = Brand.create(id: 12347, crowd_participant: false)
      expect(Brand.myBrands()).toEqual([one, two])

  describe ".newBrands", ->
    it "returns the brands of which I'm not a crowd participant in", ->
      one   = Brand.create(id: 12345, crowd_participant: true)
      two   = Brand.create(id: 12346, crowd_participant: true)
      three = Brand.create(id: 12347, crowd_participant: false)
      expect(Brand.newBrands()).toEqual([three])
