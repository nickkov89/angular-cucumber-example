require '../spec_helper'
Brand = require("#{process.cwd()}/app/models/staging_brand")

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

  describe ".totalActions", ->
    it "returns the total number of actions across all brands by default", ->
      one   = Brand.create(id: 12345, crowd_participant: true, actions_count: 1)
      two   = Brand.create(id: 12346, crowd_participant: true, actions_count: 2)
      three = Brand.create(id: 12347, crowd_participant: false, actions_count: 3)
      expect(Brand.totalActions()).toEqual(6)

    it "returns the total number of actions across a myBrands or newBrands", ->
      one   = Brand.create(id: 12345, crowd_participant: true, actions_count: 1)
      two   = Brand.create(id: 12346, crowd_participant: true, actions_count: 2)
      three = Brand.create(id: 12347, crowd_participant: false, actions_count: 4)
      Brand.myBrands = -> [one, two]
      Brand.newBrands = -> [three]
      expect(Brand.totalActions('myBrands')).toEqual(3)
      expect(Brand.totalActions('newBrands')).toEqual(4)

    it "returns zero if there are no brands", ->
      expect(Brand.totalActions()).toEqual(0)
