class CampaignsController < ApplicationController
  def new
    @campaign = Campaign.new
  end

  def create
    campaign_params = params.require(:campaign).permit(:title,
                                                       :body,
                                                       :goal,
                                                       :end_date)
    @campaign = Campaign.new campaign_params
    if @campaign.save
      redirect_to campaign_path(@campaign), notice: 'Campaign created'
    else
      render :new
    end
  end
end
