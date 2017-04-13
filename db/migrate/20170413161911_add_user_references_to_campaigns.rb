class AddUserReferencesToCampaigns < ActiveRecord::Migration[5.0]
  def change
    add_reference :campaigns, :user, foreign_key: true
  end
end
