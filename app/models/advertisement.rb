# frozen_string_literal: true

class Advertisement < ApplicationRecord
  has_many :advertisement_payment_methods
  has_many :payment_methods, through: :advertisement_payment_methods
  has_many :p2p_orders
  belongs_to :currency, required: true
  belongs_to :creator, class_name: Member.name, foreign_key: :creator_id
  belongs_to :currency_payment, class_name: Currency.name, foreign_key: :currency_payment_id

  enum advertis_type: [:sell, :buy]
  enum visible: [:disabled, :enabled]
  enum price_type: [:fixed, :floating]

  after_create :block_coin_after_create
  after_update :update_block_coin

  def update_block_coin
    if visible_changed? && disabled?
      account.unlock_funds(coin_avaiable) if sell?
    else
      account.lock_funds(coin_avaiable) if sell?
    end
  end

  def coin_avaiable
    total_amount.to_f - p2p_orders.sum(:number_of_coin).to_f
  end

  def account
    acc = creator.accounts.where(currency_id: currency_id).first
    unless acc
      acc = creator.accounts.create(currency_id: currency_id, type: "spot")
    end
    acc
  end

  def block_coin_after_create
    account.lock_funds!(total_amount) if sell? && enabled?
  end

end
