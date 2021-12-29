# frozen_string_literal: true

class P2pOrder < ApplicationRecord
  belongs_to :advertisement
  belongs_to :payment_method
  belongs_to :advertisement_payment_methods
  belongs_to :member
  has_many :attachments, as: :object

  enum status: [:ordered, :transfer, :paid, :complete, :cancel]
  enum p2p_orders_type: [:sell, :buy]
  before_update :update_coin
  after_create :block_coin_sell

  def update_coin
    if status_changed? && paid?
      successful_p2porder_transfer
    end
    if status_changed?
      send_message_status
    end
  end

  def account
    member.accounts.where(currency_id: advertisement.currency_id).first
  end

  def block_coin_sell
    account.lock_funds!(number_of_coin) if sell?
  end

  def self.build_order(params, advertis, current_user)
    order = new(params)
    order.price = advertis.price if advertis.fixed?
    order.ammount = order.number_of_coin * order.price * ((advertis.price_percent || 100)/100)
    order.order_number = SecureRandom.hex(6)
    order.p2p_orders_type = (advertis.sell? ? "buy" : "sell")
    order.member_id = current_user.id
    order
  end

  def send_message(message, member)
    url = URI('http://barong:8001/api/v2/management/phones/send')

    Net::HTTP.start(url.host, url.port, use_ssl: false) do |http|
      request = Net::HTTP::Post.new(url, 'Content-Type' => 'application/json')
      request.body = generate_jwt_management({ uid: member.uid, content: message })
      response = http.request request
      response.body
    end
  end

  def send_message_status
    if paid?
      message = "[Binance] The buyer has marked P2P Order (last 4 digit: #{order_number[8..12]}) as paid. Please release the crypto ASAP after confirming that payment has been received."
      send_message(message, member) if sell?
      send_message(message, advertisement.creator) if buy?
    elsif transfer?
      message = "[Binance] P2P Order (last 4 digit: #{order_number[8..12]}) has been completed. The seller has released #{number_of_coin} #{advertisement.currency_id} to your P2P wallet."
      send_message(message, advertisement.creator) if sell?
      send_message(message, member) if buy?
    elsif cancel?
      message = "[Binance] P2P Order (last 4 digit: #{order_number[8..12]}) has been canceled because payment was not transferred in time. Contact Customer Support if you have any questions."
      send_message(message, advertisement.creator) if sell?
      send_message(message, member) if buy?
    end
  end

  def successful_p2porder_transfer
    user_advertisement = advertisement.creator.accounts.where(currency_id: advertisement.currency_id).first
    user_order = member.accounts.where(currency_id: advertisement.currency_id).first

    if buy?
      unless user_order
        user_order = Account.create(member_id: advertisement.creator, currency_id: advertisement.currency_id, type: "spot")
      end

      user_advertisement.sub_fund(number_of_coin)
      user_order.add_fund(number_of_coin)

    elsif sell?
      if number_of_coin > user_order.try(:locked)
        return puts "your total coin is not enough to buy"
      end

      user_order.sub_fund(number_of_coin)
      user_advertisement.add_fund(number_of_coin)
    end
    update(status: :complete, claim_status: :approve)
  end

  def reason_claim
    if sell?
      {
        1 => "Tôi đã nhận được thanh toán từ người mua, nhưng số tiền không chính xác",
        2 => "Người mua đã xác nhận là đã thanh toán nhưng tôi không nhận được thanh toán vào tài khoản của mình",
        3 => "Tôi đã nhận được thanh toán từ tài khoản của bên thứ ba",
        4 => "Khác"
      }
    else
      {
        1 => "Tôi đã thanh toán, nhưng người bán không chuyển tiền điện tử",
        2 => "Trả thêm tiền cho người bán",
        3 => "Khác"
      }
    end
  end

  def total
    ammount
  end

  def amount
    ammount
  end

  def price_percent
    advertisement.price_percent
  end

end
