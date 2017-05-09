class AddAasmStateToCampaigns < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :aasm_state, :string
  end
end
