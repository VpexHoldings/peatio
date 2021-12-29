# frozen_string_literal: true

module API
  module V2
    module P2p
      module Entities
        class Member < API::V2::Entities::Base
          expose(:id)

          expose(
            :username,
            documentation: {
              desc: 'name of member',
              type: String
            }
          )

          expose(
            :email,
            documentation: {
              desc: 'email of member',
              type: String
            }
          )

          expose(:uid)

          expose(
            :accounts,
            using: API::V2::P2p::Entities::Account,
            documentation: {
              type: 'API::V2::P2p::Entities::Account',
              is_array: true,
              uniq: true,
              desc: 'Balancer of member'
            }
          )

          expose(
            :payment_methods,
            using: API::V2::P2p::Entities::PaymentMethod,
            documentation: {
              type: 'API::V2::Public::Entities::PaymentMethod',
              is_array: true,
              uniq: true,
              desc: 'Payment info of member'
            },
            ) do |c|
            c.payment_methods
          end
        end
      end
    end
  end
end
