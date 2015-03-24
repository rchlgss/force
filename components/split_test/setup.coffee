_ = require 'underscore'
runningTests = require './running_tests.coffee'
SplitTest = require './split_test.coffee'

module.exports = ->
  return if _.isEmpty runningTests

  for key, configuration of runningTests
    new SplitTest(configuration)?.outcome()