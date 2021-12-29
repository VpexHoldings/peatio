# encoding: UTF-8
# frozen_string_literal: true
require "date"

module API::V2
  module P2p
    class Advertisements < Grape::API
      helpers ::API::V2::P2p::NamedParams
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
        search_attrs = { m: 'or' }

        present paginate(Rails.cache.fetch("advertis_#{params}_p2p", expires_in: 6) do

          result = Advertisement.send(params[:advertis_type] || "sell").enabled.order('created_at DESC')
          result = result.where(currency_id: params[:currency_id]) if params[:currency_id].present?
          result = result.where(currency_payment_id: params[:currency_payment_id]) if params[:currency_payment_id].present?
          result = result.ransack(search_attrs)
          result = result.result.load.to_a.select { |adv| current_user.is_quantified_to_trade?(adv.creator_id) && current_user.is_enough_time_registration?(adv.member_registration_day.to_i) &&
            current_user.is_hold_enough_coin?(adv) && current_user.is_kyc? && adv.coin_avaiable > 0 }
          result
        end), with: API::V2::Entities::Advertisement
      end

      #--------------------------------------------------------------------------------------------------------------
      desc 'Create advertisement',
           is_array: true,
           success: API::V2::Entities::Advertisement
      params do
        use :param_advertisement
      end
      post '/advertisements' do

        unless current_user.is_kyc?
          return error!({ errors: ['member.is_kyc_false'] }, 412)
        end

        if params[:payment_method_ids].count > 5
          return error!({ errors: ['advertis.ability.payment_method_limit'] }, 412)
        end

        ads = Advertisement.new(params[:advertisement])

        if ads.sell?
          balance = current_user.accounts.where(currency_id: ads.currency_id).first.try(:balance)
          if balance.to_f < 0
            return error!({ errors: ['advertis.ability.balance_not_enough'] }, 412)
          end
        end

        unless Currency.find_by id: ads.currency_id
          return error!({ errors: ['currency_id.doesnt_exist'] }, 404)
        end

        unless Currency.find_by id: ads.currency_payment_id
          return error!({ errors: ['currency_payment_id.doesnt_exist'] }, 404)
        end

        ads.creator_id = current_user.id
        params[:payment_method_ids].each do |payment_method_id|
          unless PaymentMethod.find_by(id: payment_method_id, member_id: current_user.id)
            return error!({ errors: ['payment_method.doesnt_exist'] }, 404)
          end
          ads.advertisement_payment_methods << AdvertisementPaymentMethod.new(payment_method_id: payment_method_id)
        end

        if ads.valid?
          ads.save
          present ads, with: API::V2::Entities::Advertisement
        else
          return error!({ errors: ['advertisement.create_errors'] }, 412)
        end
      end

      #----------------------------------------------------------------------------------------------------------------------

      desc 'Get all Advertis and search',
           is_array: true,
           success: API::V2::Entities::Advertisement
      params do
        use :pagination
      end
      get '/my_advertises' do
        search_attrs = {m: 'and', "creator_id_eq": current_user.id}
        search_attrs["advertis_type_eq"] = params[:advertis_type] if params[:advertis_type].present?
        search_attrs["price_type_eq"] = params[:price_type] if params[:price_type].present?
        search_attrs["currency_id_eq"] = params[:currency_id] if params[:currency_id].present?
        search_attrs["currency_payment_id_eq"] = params[:currency_payment_id] if params[:currency_payment_id].present?
        search_attrs["visible_eq"] = params[:visible] if params[:visible].present?

        start_date = Date.parse(params[:start_date]|| (Time.now - 10.years).to_s).to_s
        end_date = Date.parse(params[:end_date]|| (Time.now + 1.day).to_s).to_s

        present paginate(Rails.cache.fetch("myadvertis_#{params}", expires_in: 6) do
          result = Advertisement.where("created_at >= ? and created_at <= ?", start_date, end_date)
                                .order('created_at DESC')
          result = result.ransack(search_attrs)
          result = result.result.load.to_a
          result
        end), with: API::V2::Entities::Advertisement
      end

      #----------------------------------------------------------------------------------------------------------------------

      desc 'Show a Advertis',
           is_array: true,
           success: API::V2::Entities::Advertisement
      get '/my_advertise/:id' do
        ads = Advertisement.find_by(id: params[:id], creator_id: current_user.id)
        unless ads
          return error!({ errors: ['advertis.ability.not_found'] }, 404)
        end
        present ads, with: API::V2::Entities::Advertisement
      end

      #-----------------------------------------------------------------------------------------------------------------

      desc 'Update advertisement',
           is_array: true,
           success: API::V2::Entities::Advertisement
      params do
        use :param_advertisement
      end
      post '/my_advertise/:id' do
        ads = Advertisement.find_by(id: params[:id], creator_id: current_user.id)
        unless ads
          return error!({ errors: ['advertis.ability.not_found'] }, 404)
        end
        ads_new = Advertisement.new(params[:advertisement])

        if ads_new.sell?
          balance = current_user.accounts.where(currency_id: ads_new.currency_id).first.try(:balance)
          if (balance.to_f + ads.coin_avaiable) < ads_new.coin_avaiable
            return error!({ errors: ['account.balance.not_enough'] }, 412)
          end
        end

        if params[:payment_method_ids].count > 5
          return error!({ errors: ['payment_method.limit'] }, 412)
        end

        unless Currency.find_by id: ads_new.currency_id
          return error!({ errors: ['currency_id.doesnt_exist'] }, 404)
        end

        unless Currency.find_by id: ads_new.currency_payment_id
          return error!({ errors: ['currency_payment_id.doesnt_exist'] }, 404)
        end

        ads_new.creator_id = current_user.id
        params[:payment_method_ids].each do |payment_method_id|
          unless PaymentMethod.find_by(id: payment_method_id, member_id: current_user.id)
            return error!({ errors: ['payment_method.doesnt_exist'] }, 404)
          end
          ads_new.advertisement_payment_methods << AdvertisementPaymentMethod.new(payment_method_id: payment_method_id)
        end

        if ads_new.valid?
          ads.update(visible: :disabled)
          ads_new.save
          present ads_new, with: API::V2::Entities::Advertisement
        else
          return error!({ errors: ['advertisement.update_errors'] }, 412)
        end
      end
    end
  end
end
