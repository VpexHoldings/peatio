# frozen_string_literal: true

module API
  module V2
    module P2p
      module Entities
        class P2pOrderClaim < API::V2::Entities::Base
          expose(
            :id,
            documentation: {
              desc: 'id of P2pOrderClaim',
              type: Integer
            }
          )

          expose(
            :p2p_order_id,
            documentation: {
              desc: 'p2p_order_id of P2pOrderClaim',
              type: Integer
            }
          )

          expose(
            :status,
            documentation: {
              desc: 'status of P2pOrderClaim',
              type: Integer
            }
          )

          expose(
            :member_id,
            documentation: {
              desc: 'member_id of P2pOrderClaim',
              type: Integer
            }
          )

          expose(
            :reason,
            documentation: {
              desc: 'reason of P2pOrderClaim',
              type: String
            }
          )

          expose(
            :description,
            documentation: {
              desc: 'description of P2pOrderClaim',
              type: String
            }
          )

          expose(
            :order_number,
            documentation: {
              desc: 'order_number of P2pOrderClaim',
              type: String
            }
          )

          expose(
            :claim_type,
            documentation: {
              desc: 'claim_type of P2pOrderClaim',
              type: String
            }
          )

          expose(:reason_claim)
          expose(:note)
          expose(
            :member,
            using: API::V2::P2p::Entities::Member,
            documentation: {
              type: 'API::V2::P2p::Entities::Member',
              is_array: true,
              uniq: true,
              desc: 'member if claim',
              type: String
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

          expose(
            :created_at,
            documentation: {
              desc: 'created at of P2pOrderClaim',
              type: String
            }
          )

          private

          def claim_type
            ::P2pOrderClaim::claim_types[object["claim_type"]]
          end
        end
      end
    end
  end
end
