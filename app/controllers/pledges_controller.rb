class PledgesController < ApplicationController
  before_action :authenticate_user!

  def create
    @pledge = Pledge.new pledge_params
    @campaign = Campaign.find params[:campaign_id]
    @pledge.campaign = @campaign
    @pledge.user = current_user
    if @pledge.save
      redirect_to new_pledge_payment_path(@pledge), notice: 'Please make a payment'
    else
      render 'campaigns/show'
    end
  end

  private

  def pledge_params
    params.require(:pledge).permit(:amount)
  end
end
