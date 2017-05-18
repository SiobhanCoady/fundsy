class AddStripeChargeIdToPledges < ActiveRecord::Migration[5.0]
  def change
    add_column :pledges, :stripe_charge_id, :string
  end
end
