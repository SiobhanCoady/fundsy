class CampaignsController < ApplicationController
  before_action :authenticate_user!

  def new
    @campaign = Campaign.new
  end

  def create
    campaign_params = params.require(:campaign).permit(:title,
                                                       :body,
                                                       :goal,
                                                       :end_date)
    @campaign = Campaign.new campaign_params
    @campaign.user = current_user
    if @campaign.save
      redirect_to campaign_path(@campaign), notice: 'Campaign created'
    else
      render :new
    end
  end

  def edit
    @campaign = Campaign.find params[:id]
    redirect_to root_path unless can? :edit, @campaign
  end

  def destroy
    campaign = Campaign.find params[:id]
    campaign.destroy
  end
end
