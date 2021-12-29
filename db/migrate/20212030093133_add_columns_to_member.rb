class AddColumnsToMember < ActiveRecord::Migration[5.2]
  def change
    change_column :members, :is_kyc, :boolean, :default => false
  end
end
