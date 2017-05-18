class AddStripeInfoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :stripe_customer_id, :string
    add_column :users, :stripe_card_brand, :string
    add_column :users, :stripe_last4, :string
    add_column :users, :stripe_card_expiry, :string
  end
end
