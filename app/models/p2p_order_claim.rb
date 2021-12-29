# frozen_string_literal: true

class P2pOrderClaim < ApplicationRecord

  has_many :attachments, as: :object
  belongs_to :member
  belongs_to :p2p_order

  enum status: [:request, :approve, :canceled]
  enum claim_type: [:buyer, :seller]
  before_update :release_coin_approve


  def release_coin_approve
    if status_changed? && approve?
      p2p_order.update(status: :paid)
    end
  end

  def self.create_claim(order, params)
    claim = P2pOrderClaim.new(p2p_order_id: order.id)
    claim.creator_adv_id = order.advertisement.creator_id
    claim.member_id = order.member_id
    claim.reason = params[:reason]
    claim.claim_type = claim.get_claim_type(order)
    claim.description = params[:description]
    claim.status = "request"
    (params[:claim_images] || []).each do |image|
      claim.attachments.new(image: image)
    end
    claim.save
  end

  def order_number
    p2p_order.order_number
  end

  def get_claim_type(order)
    type_else = order.p2p_orders_type == "sell" ? "sell" : "buy"
    creator_adv_id == member_id ? (order.p2p_orders_type + 'er') :  (type_else + "er")
  end

  def reason_claim
    if p2p_order.sell?
      {
        1 => "Tôi đã thanh toán, nhưng người bán không chuyển tiền điện tử",
        2 => "Trả thêm tiền cho người bán",
        3 => "Khác"
      }
    else
      {
        1 => "Tôi đã nhận được thanh toán từ người mua, nhưng số tiền không chính xác",
        2 => "Người mua đã xác nhận là đã thanh toán nhưng tôi không nhận được thanh toán vào tài khoản của mình",
        3 => "Tôi đã nhận được thanh toán từ tài khoản của bên thứ ba",
        4 => "Khác"
      }
    end
  end

  def member_uid
    member.uid
  end
end