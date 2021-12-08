# encoding: UTF-8
# frozen_string_literal: true

module API
  module V2
    module P2p
      module NamedParams
        extend ::Grape::API::Helpers

        # Create P2p_orders
        params :p2p_order do
          requires :p2p_orders_type,
                   type: String,
                   values: { value: %w(sell buy), message: 'p2p.p2p_order.invalid_p2p_order_type' },
                   desc: -> { V2::Entities::P2pOrder.documentation[:p2p_orders_type] }
          requires :advertisement_id,
                   type: Integer,
                   values: { value: -> (v) { (Advertisement.find_by id: v).present? }, message: 'p2p.p2p_order.non_advertisement' },
                   desc: -> { V2::Entities::P2pOrder.documentation[:advertisement_id] }
          requires :number_of_coin,
                   type: BigDecimal,
                   values: { value: -> (v) { v.try(:positive?) }, message: 'p2p.p2p_order.non_positive_number_of_coin' },
                   desc: -> { V2::Entities::P2pOrder.documentation[:number_of_coin] }
        end

        params :p2p_edit do
          optional :status,
                   type: String,
                   values: { value: %w(ordered paid complete cancel), message: 'p2p.p2p_order.invalid_p2p_status' },
                   desc: -> { V2::Entities::P2pOrder.documentation[:status] }

          optional :payment_method_id,
                   type: Integer
        end

        # Create Advertisement
        params :param_advertisement do
          requires :advertisement, type: JSON, default: {} do
            requires :advertis_type,
                     type: String,
                     values: { value: %w(sell buy), message: 'p2p.advertisement.invalid_advertis_type' },
                     desc: -> { V2::Entities::P2pOrder.documentation[:advertis_type] }

            requires :currency_id,
                     type: String,
                     desc: -> { V2::Entities::P2pOrder.documentation[:currency_id] }

            requires :currency_payment_id,
                     type: String,
                     desc: -> { V2::Entities::P2pOrder.documentation[:currency_payment_id] }

            requires :price_type,
                     type: String,
                     values: { value: %w(fixed floating), message: 'p2p.p2p_order.invalid_price_type' },
                     desc: -> { V2::Entities::P2pOrder.documentation[:price_type] }

            requires :total_amount,
                     type: String,
                     desc: -> { V2::Entities::P2pOrder.documentation[:total_amount] }

            requires :upper_limit,
                     type: String,
                     desc: -> { V2::Entities::P2pOrder.documentation[:upper_limit] }

            requires :lower_limit,
                     type: String,
                     desc: -> { V2::Entities::P2pOrder.documentation[:lower_limit] }

            requires :description,
                     type: String,
                     desc: -> { V2::Entities::P2pOrder.documentation[:description] }

            requires :visible,
                     type: String,
                     values: { value: %w(disabled enabled), message: 'p2p.advertisement.invalid_visible' },
                     desc: -> { V2::Entities::P2pOrder.documentation[:visible] }

            requires :price,
                     type: String,
                     desc: -> { V2::Entities::P2pOrder.documentation[:price] }

            requires :expired_time,
                     type: Integer,
                     desc: -> { V2::Entities::P2pOrder.documentation[:expired_time] }

          end

          requires :payment_method_ids,
                   type: Array

        end
      end
    end
  end
end
