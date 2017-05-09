class AddLongitudeLatitudeToCampaigns < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :longitude, :float
    add_column :campaigns, :latitude, :float
  end
end
