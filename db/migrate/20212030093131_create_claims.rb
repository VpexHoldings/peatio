class CreateClaims < ActiveRecord::Migration[5.2]
  def change
    create_table :p2p_order_claims do |t|
      t.integer :member_id
      t.string :reason
      t.string :description
      t.integer :status
      t.integer :p2p_order_id
      t.integer :creator_adv_id

      t.timestamps
    end
  end
end
