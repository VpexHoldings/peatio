class AddKycToAdvertisment < ActiveRecord::Migration[5.2]
  def change
    add_column :advertisements, :is_kyc, :boolean, :default => true
  end
end
