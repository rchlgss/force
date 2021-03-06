_ = require 'underscore'
IS_TEST_ENV = require '../../lib/is_test_env.coffee'

module.exports = (remote = {}, options = {}) ->
  throw new Error 'requires `remote`' unless remote?

  return { initialize: (->) } if IS_TEST_ENV

  settings = _.defaults options,
    limit: 4
    remote: remote
    identify: _.uniqueId 'bloodhound'
    datumTokenizer: Bloodhound.tokenizers.whitespace
    queryTokenizer: Bloodhound.tokenizers.whitespace

  # Bloodhound is exposed through typehead's require within
  # ./components/main_layout/client.coffee
  new Bloodhound settings
