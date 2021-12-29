# frozen_string_literal: true

module API::V2
  module P2p
    class Mount < Grape::API

      before { authenticate! }

      mount P2p::P2pOrders
      mount P2p::Advertisements
      mount P2p::Member
      mount P2p::P2pOrderClaims
    end
  end
end
