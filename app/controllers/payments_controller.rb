class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @pledge = Pledge.find params[:pledge_id]
  end

  def create

    # TO DO:
    # 1- When connecting with external services such as Stripe, it's always
    #    advisable that we handle exception because we're not in control with
    #    what happens on Stripe.
    # 2- This controller action is getting too long, so we should look into
    #    refactoring it to a common pattern such as: Service Objects
    # 3- We should handle a situation when the user has already signed up with
    #    us before and created a Stripe Customer, so we can just add the card
    #    instead of re-creating the customer on Stripe every time.

    begin
      customer = Stripe::Customer.create(
      :description => "Customer for #{current_user.id} | #{current_user.email}",
      :source => params[:stripe_token]
      )

      card_info = customer.sources.data[0]
      exp = "#{card_info.exp_month}/#{card_info.exp_year}"
      current_user.update stripe_customer_id: customer.id,
      stripe_card_brand: card_info.brand,
      stripe_last4: card_info.last4,
      stripe_card_expiry: exp

      @pledge = Pledge.find params[:pledge_id]
      charge = Stripe::Charge.create(
      :amount => @pledge.amount * 100,
      :currency => "cad",
      :customer => customer.id,
      :description => "Pledge #{@pledge.id} Payment"
      )
      @pledge.update stripe_charge_id: charge.id

      redirect_to @pledge.campaign, notice: 'Thanks for completing the payment'
    rescue
      flash.now[:alert] = 'Error happened while finalizing payment'
      render :new
    end
  end
end
