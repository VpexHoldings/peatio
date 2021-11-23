# encoding: UTF-8
# frozen_string_literal: true

module API
  module V2
    module Entities
      class Advertisement < Base
      	expose(
          :price,
          documentation: {
            type: BigDecimal,
            desc: "Price for each unit. e.g."\
                  "If you want to sell/buy 1 btc at 3000 usd, the price is '3000.0'" 
          }
        )

        expose(
          :advertis_type,
          documentation: {
            type: Integer,
            desc: "sell/buy"
          }
        )

        expose(
          :avaiable_coin,
          documentation: {
            type: BigDecimal,
            desc: "sell/buy how many coin?"
          }
        )

        expose(
          :upper_limit,
          documentation: {
            type: BigDecimal,
            desc: "sell/buy how many max money?"
          }
        )

        expose(
          :lower_limit,
          documentation: {
            type: BigDecimal,
            desc: "sell/buy how many min money?"
          }
        )

        expose(
          :description,
          documentation: {
            type: String,
            desc: "description of sell/buy"
          }
        )

        expose(
          :currency,
          :using => API::V2::P2p::Entities::Currency,
          documentation: {
            desc: 'Currency.'
          }
        )

        expose(
          :creator,
          :using => API::V2::P2p::Entities::Member,
          documentation: {
            desc: 'name of creator.'
          }
        )

      end
    end
  end
end
