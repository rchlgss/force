benv = require 'benv'
Backbone = require 'backbone'
{ resolve } = require 'path'
{ fabricate } = require 'antigravity'
Artwork = require '../../../../../models/artwork'
RelatedNavigationView = benv.requireWithJadeify resolve(__dirname, '../view'), ['template']

describe 'RelatedNavigationView', ->
  before (done) ->
    benv.setup ->
      benv.expose $: benv.require 'jquery'
      Backbone.$ = $
      done()

  after ->
    benv.teardown()

  beforeEach ->
    @artwork = new Artwork fabricate 'artwork'
    @view = new RelatedNavigationView model: @artwork

  describe 'nothing worth rendering', ->
    it 'renders correctly', ->
      @view.render().$el.is(':empty').should.be.true

  describe 'with a related auction', ->
    beforeEach ->
      @view.model.related().features.add fabricate 'feature'
      @view.model.related().sales.add fabricate 'sale', is_auction: true

    it 'renders correctly', ->
      html = @view.render().$el.html()
      html.should.containEql 'Work offered by'
      html.should.containEql 'Go to auction'

  describe 'with a related sale', ->
    describe 'that is a normal sale', ->
      beforeEach ->
        @view.model.related().features.add fabricate 'feature'
        @view.model.related().sales.add fabricate 'sale', is_auction: false

      it 'renders correctly', ->
        html = @view.render().$el.html()
        html.should.containEql 'Work offered by'
        html.should.containEql 'Go to sale'

    describe 'that is an "auction promo"', ->
      describe 'sans profile', ->
        beforeEach ->
          @view.model.related().sales.add fabricate 'sale', is_auction: false, sale_type: 'auction promo', name: 'A Promo'

        it 'renders correctly', ->
          html = @view.render().$el.html()
          html.should.containEql 'Work offered by A Promo'

      describe 'with profile', ->
        beforeEach ->
          @view.model.related().sales.add fabricate 'sale',
            is_auction: false
            sale_type: 'auction promo'
            name: 'A Promo'
            profile: fabricate 'profile', owner: name: 'Foo Bar'

        it 'renders correctly', ->
          html = @view.render().$el.html()
          html.should.containEql 'Work offered by Foo Bar'
          html.should.containEql '<img src'

  describe 'with a related fair', ->
    describe 'that is linkable', ->
      beforeEach ->
        @view.model.related().fairs.add fabricate 'fair', has_full_feature: true, published: true

      it 'renders correctly', ->
        html = @view.render().$el.html()
        html.should.containEql 'Work offered by'
        html.should.containEql 'Go to fair'

    describe 'that is not linkable', ->
      beforeEach ->
        @view.model.related().fairs.add fabricate 'fair', has_full_feature: false, published: true

      it 'renders correctly', ->
        @view.render().$el.is(':empty').should.be.true