class NearbyCampaignsController < ApplicationController

  def index
    cookies[:lng] = params[:lng] if params[:lng]
    cookies[:lat] = params[:lat] if params[:lat]
    @campaigns = Campaign.near([params[:lat], params[:lng]], 50, units: :km)
    @markers = Gmaps4rails.build_markers(@campaigns) do |campaign, marker|
                marker.lat campaign.latitude
                marker.lng campaign.longitude
                marker.infowindow campaign.title
              end
  end
end
