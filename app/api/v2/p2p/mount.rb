# frozen_string_literal: true

module API::V2
  module P2p
    class Mount < Grape::API

      mount P2p::P2pOrders
    end
  end
end
