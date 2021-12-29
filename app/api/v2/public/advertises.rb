# encoding: UTF-8
# frozen_string_literal: true

module API::V2
  module Public
    class Advertises < Grape::API
      helpers ::API::V2::ParamHelpers

      desc 'Get all Advertis and search',
        is_array: true,
        success: API::V2::Entities::Advertisement
      params do
        use :pagination
        optional :advertis_type,
                 type: String,
                 values: { value: %w[sell buy], message: 'public.advertis.invalid_type' },
                 desc: -> { API::V2::Entities::Advertisement.documentation[:advertis_type][:desc] }
        optional :currency_id,
                 type: String
        optional :currency_payment_id,
                 type: String
        optional :page,
                 type: String
        optional :search, type: JSON, default: {} do
          optional :location,
                   type: String,
                   desc: 'Search by location using SQL LIKE'
          optional :amount,
                   type: BigDecimal,
                   desc: 'Search by amount using SQL <='
          optional :payment_method,
                   type: String,
                   desc: 'Search by payment method SQL'
        end
      end
      get '/advertises' do
        search_attrs = {m: 'or'}

        # present paginate(Rails.cache.fetch("advertis_#{params}", expires_in: 6) do

          result = Advertisement.send(params[:advertis_type] || "sell").enabled.order('created_at DESC')
          result = result.where(currency_id: params[:currency_id]) if params[:currency_id].present?
          result = result.where(currency_payment_id: params[:currency_payment_id]) if params[:currency_payment_id].present?
          result = result.ransack(search_attrs)
          result = result.result.load.to_a.select{|adv| adv.coin_avaiable > 0}
          result
        present result, with: API::V2::Entities::Advertisement
        # end), with: API::V2::Entities::Advertisement
      end
    end
  end
end
