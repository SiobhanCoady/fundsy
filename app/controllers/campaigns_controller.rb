class CampaignsController < ApplicationController
  before_action :authenticate_user!

  def new
    @campaign = Campaign.new
    3.times { @campaign.rewards.build }
  end

  def create
    @campaign = Campaign.new campaign_params
    @campaign.user = current_user
    if @campaign.save
      redirect_to campaign_path(@campaign), notice: 'Campaign created'
    else
      render :new
    end
  end

  def show
    @campaign = Campaign.find params[:id]
    @pledge = Pledge.new
  end

  def edit
    @campaign = Campaign.find params[:id]
    redirect_to root_path unless can? :edit, @campaign
  end

  def destroy
    campaign = Campaign.find params[:id]
    campaign.destroy
  end

  private

  def campaign_params
    params.require(:campaign).permit(:title,
                                     :body,
                                     :goal,
                                     :end_date,
                                     { rewards_attributes: [ :title,
                                                             :body,
                                                             :amount,
                                                             :id,
                                                             :_destroy
                                                             ]
                                      })
  end
end
