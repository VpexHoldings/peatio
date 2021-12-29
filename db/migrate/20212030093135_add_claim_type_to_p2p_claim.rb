class AddClaimTypeToP2pClaim < ActiveRecord::Migration[5.2]
  def change
    add_column :p2p_order_claims, :claim_type, :integer
    add_column :p2p_order_claims, :member_admin_id, :integer
    add_column :p2p_order_claims, :note, :string
  end
end
