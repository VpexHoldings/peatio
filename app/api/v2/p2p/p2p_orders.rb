# encoding: UTF-8
# frozen_string_literal: true

module API::V2
  module P2p
    class P2pOrders < Grape::API
      helpers ::API::V2::P2p::NamedParams
      helpers ::API::V2::ParamHelpers

      desc 'Create P2p order',
           is_array: true,
           success: API::V2::Entities::P2pOrder
      params do
        use :p2p_order
      end
      post '/p2p_orders' do
        user_authorize! :create, ::P2pOrder

        advertis = Advertisement.find_by id: params[:advertisement_id]
        order = P2pOrder.build_order(params, advertis, current_user)

        if order.sell?
          return error!({ errors: ['advertisements.coin_not_enough'] }, 412) if order.number_of_coin > advertis.coin_avaiable
        end

        return error!({ errors: ['member.unverified_identity'] }, 412) unless current_user.is_kyc?
        return error!({ errors: ['member.lack_of_use_date'] }, 412) unless current_user.is_enough_time_registration?(advertis.member_registration_day.to_i)
        return error!({ errors: ['member.insufficient_coins'] }, 412) unless current_user.is_hold_enough_coin?(advertis)

        unless order.save
          return error!({ errors: ['p2p_order.created_unsuccess'] }, 412)
        end

        present :order, order, with: API::V2::Entities::P2pOrder
      end

      #-----------------------------------------------------------------------------------------------------------------
      desc 'Edit P2p order',
           is_array: true,
           success: API::V2::Entities::P2pOrder
      params do
        use :p2p_edit
      end
      post '/p2p_order/:id' do
        order = P2pOrder.find_by id: params[:id]
        if order.blank?
          return present "Order not found"
        end
        payment_method_ids = order.advertisement.advertisement_payment_methods.pluck(:payment_method_id)
        if params[:payment_method_id].present? && !payment_method_ids.include?(params[:payment_method_id])
          return present "Invalid payment method"
        end
        if order.cancel? && params[:status] == "transfer"
          return present "cannot update because order is exp!"
        end

        order.status = params[:status] if params[:status].present?
        order.payment_method_id = params[:payment_method_id] if params[:payment_method_id].present?
        (params[:images] || []).each do |image|
          order.attachments.new(image: image)
        end
        order.save
        present :order, order, with: API::V2::Entities::P2pOrder
      end

      #-----------------------------------------------------------------------------------------------------------------
      desc 'List P2p order',
           is_array: true,
           success: API::V2::Entities::P2pOrder
      params do
        use :p2p_orders
      end
      get '/member/p2p_orders' do
        search_attrs = { m: 'and' }
        search_attrs["status_in"] = params[:status].split(",") if params[:status].present?
        search_attrs["order_number_eq"] = params[:order_number] if params[:order_number].present?
        search_attrs["p2p_orders_type_eq"] = params[:p2p_orders_type] if params[:p2p_orders_type].present?
        order = P2pOrder.joins(:advertisement).where("advertisements.creator_id = ? OR p2p_orders.member_id = ?", current_user.id, current_user.id).order(updated_at: :desc)
        order = order.ransack(search_attrs).result
        present order, with: API::V2::Entities::P2pOrder
      end

      desc 'Show P2p order',
           is_array: true,
           success: API::V2::Entities::P2pOrder
      get '/p2p_order/:id' do
        order = P2pOrder.find_by id: params[:id]
        unless order
          return present 'id not found!'
        end
        present order, with: API::V2::Entities::P2pOrder
      end

      desc 'GET form P2p order claim',
           is_array: true,
           success: API::V2::Entities::P2pOrder
      get '/p2p_order/:id/claim' do
        order = P2pOrder.find_by id: params[:id]
        unless order
          return present 'id not found!'
        end
        present order, with: API::V2::Entities::P2pOrder
      end

      desc 'Admin approve order',
           is_array: true,
           success: API::V2::P2p::Entities::P2pOrderClaim
      params do
        use :p2p_admin_approve
      end

      post '/admin/p2p_orders/:id/approve' do
        order = P2pOrder.find_by id: params[:id]
        if order.status == 'paid'
          if order.update(params)
            present :complete_order, order.successful_p2porder_transfer
            order.update(status: :complete)
            present :order, order
          else
            present "update fail!"
          end
        else
          present "order has not been paid"
        end
      end
    end
  end
end
