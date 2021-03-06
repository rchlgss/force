moment = require 'moment'
{ PREDICTION_URL } = require('sharify').data

module.exports =
  mpLiveSaleIsOpen: (sale) ->
    sale.live_start_at? and
      moment().isBefore(sale.end_at) and
      moment().isAfter(sale.live_start_at)

  liveAuctionUrl: (saleId) ->
    "#{PREDICTION_URL}/#{saleId}"
