# encoding: UTF-8
# frozen_string_literal: true

module API
  module V2
    module Entities
      class P2pOrder < Base
        expose(
          :id,
          documentation: {
            type: Integer,
            desc: "id of p2p order."
          }
        )

        expose(
          :status,
          documentation: {
            desc: 'status of p2p order.'
          }
        )

        expose(
          :p2p_orders_type,
          documentation: {
            type: Integer,
            desc: "type of p2p order."
          }
        )

        expose(
          :price,
          documentation: {
            type: BigDecimal,
            desc: "price of p2p order."
          }
        )

        expose(
          :price_percent,
          documentation: {
            type: BigDecimal,
            desc: "price_percent of p2p order."
          }
        )

        expose(
          :amount,
          documentation: {
            type: BigDecimal,
            desc: "amount of p2p order."
          }
        )

        expose(
          :total,
          documentation: {
            type: BigDecimal,
            desc: "amount of p2p order."
          }
        )

        expose(
          :number_of_coin,
          documentation: {
            type: BigDecimal,
            desc: "number_of_coin of p2p order."
          }
        )

        expose(
          :order_number,
          documentation: {
            type: String,
            desc: "order number of p2p order."
          }
        )

        expose(
          :payment_method ,
          :using => API::V2::P2p::Entities::PaymentMethod,
          documentation: {
            desc: 'payment of creator.'
          }
        )

        expose(
          :advertisement,
          :using => API::V2::Entities::Advertisement,
          documentation: {
            desc: 'aertisment of p2p order.'
          }
        )

        expose(
          :member_id ,
          documentation: {
            desc: 'member_id of creator p2porder.'
          }
        )

        expose(
          :created_at ,
          documentation: {
            desc: 'created at of p2porder.'
          }
        )

        expose(
          :claim_status,
          documentation: {
            desc: 'claim_status of p2porder.'
          }
        )

        expose(
          :claim_description,
          documentation: {
            desc: 'claim_description.'
          }
        )

        expose(
          :claim_title,
          documentation: {
            desc: 'claim_title.'
          }
        )

        expose(
          :reason_claim,
          documentation: {
            desc: "claim reason."
          }
        )


        expose(
          :attachments,
          using: API::V2::P2p::Entities::Attachment,
          documentation: {
            type: 'API::V2::P2p::Entities::Attachment',
            is_array: true,
            uniq: true,
            desc: 'images at of Claim',
            type: String
          }
        )

      end
    end
  end
end
