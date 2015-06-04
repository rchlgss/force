{ ARTIST } = require('sharify').data
Backbone = require 'backbone'
scrollFrame = require 'scroll-frame'
Artist = require '../../../models/artist.coffee'
CurrentUser = require '../../../models/current_user.coffee'
ArtistRouter = require './router.coffee'
analytics = require './analytics.coffee'

module.exports.init = ->
  artist = new Artist ARTIST
  user = CurrentUser.orNull()

  analytics artist

  scrollFrame 'a.artwork-item-image-link'

  router = new ArtistRouter model: artist, user: user
  Backbone.history.start pushState: true