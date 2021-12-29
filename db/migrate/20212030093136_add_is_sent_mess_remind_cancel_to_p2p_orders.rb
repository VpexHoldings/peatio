class AddIsSentMessRemindCancelToP2pOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :p2p_orders, :is_sent_mess_remind_cancel, :boolean, :default => false
  end
end
