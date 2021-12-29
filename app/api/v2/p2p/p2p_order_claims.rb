# encoding: UTF-8
# frozen_string_literal: true

module API::V2
  module P2p
    class P2pOrderClaims < Grape::API
      helpers ::API::V2::P2p::NamedParams
      helpers ::API::V2::ParamHelpers

      #------------------------------------------------------
      desc 'Create P2p order claim',
           is_array: true,
           success: API::V2::P2p::Entities::P2pOrderClaim
      params do
        use :p2p_claim
      end

      post '/p2p_order/:id/claim' do
        order = P2pOrder.find_by id: params[:id]
        unless order
          return error!({ errors: ['p2p_order.not_found!'] }, 404)
        end
        if P2pOrderClaim.create_claim(order, params)
          present "Create claim order success!"
        else
          return error!({ errors: ['p2p_order_claim.create_failed!'] }, 412)
        end

      end

      #----------------------------------------------------------
      desc 'List claim P2pOrder',
           is_array: true,
           success: API::V2::P2p::Entities::P2pOrderClaim
      get '/claims' do
        if params[:order_number]
          p2p_oder_id = P2pOrder.find_by(order_number: params[:order_number]).try(:id)
        end
        search_attrs = {m: 'and', "creator_id_eq": current_user.id}
        search_attrs["claim_type_eq"] = params[:claim_type].to_i if params[:claim_type].present?
        search_attrs["status_in"] = params[:status].split(",") if params[:status].present?
        search_attrs["member_id_eq"] = params[:member_id].to_i if params[:member_id].present?
        search_attrs["p2p_order_id_eq"] = p2p_oder_id if p2p_oder_id.present?

        if current_user.admin?
          list_order_claim = P2pOrderClaim.order(updated_at: :desc)
        else
          list_order_claim = P2pOrderClaim.where(member_id: current_user.id)
                                          .or(P2pOrderClaim.where(creator_adv_id: current_user.id))
                                          .order(updated_at: :desc)
        end
        list_order_claim = list_order_claim.ransack(search_attrs)
        list_order_claim = Kaminari.paginate_array(list_order_claim.result.load.to_a).page(params[:page] || 1).per(params[:limit] || 10)
        present list_order_claim, with: API::V2::P2p::Entities::P2pOrderClaim
      end

      #---------------------------------------------------------------
      desc 'Show claim',
           is_array: true,
           success: API::V2::P2p::Entities::P2pOrderClaim
      get '/claim/:claim_id' do
        claim = P2pOrderClaim.find_by id: params[:claim_id]
        return error!({ errors: ['p2p_order_claim.not_found!'] }, 404) unless claim
        present claim, with: API::V2::P2p::Entities::P2pOrderClaim
      end

      #---------------------------------------------------------------------
      desc 'Update Claim',
           is_array: true,
           success: API::V2::P2p::Entities::P2pOrderClaim
      params do
        use :p2p_claim_update
      end

      post '/claim/:id' do
        claim = P2pOrderClaim.find_by id: params[:id]
        return error!({ errors: ['p2p_order_claim.not_found!'] }, 404) unless claim

        claim.reason = params[:reason] if params[:reason]
        claim.description = params[:description] if params[:description]
        claim.status = params[:status].to_i if params[:status]
        claim.member_admin_id = params[:member_admin_id] if params[:member_admin_id]
        claim.note = params[:note] if params[:note]
        if claim.valid?
          if params[:reason].present?
            claim.attachments.destroy_all
            (params[:claim_images] || []).each do |image|
              claim.attachments.new(image: image)
            end
          end
          claim.save
          present claim, with: API::V2::P2p::Entities::P2pOrderClaim
        else
          return error!({ errors: ['p2p_order_claim.create_failed!'] }, 412)
        end
      end

      #--------------------------------------------------------------------------

    end
  end
end
