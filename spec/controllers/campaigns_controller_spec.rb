require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  describe '#new' do
    it 'renders the new template' do
      # GIVEN: Nothing (just the created Rails controller)

      # WHEN: We make a GET request to the 'new' action in CampaignsController
      # RSpec Rails makes it super easy to mimic the GET request by doing:
      get :new

      # THEN: We render the 'new' template
      # RSpec Rails gives us access to the controller's 'request' and 'response'
      # objects to make it easy to manipulate or match. We usually manipulate
      # the request object (to mimic user signed in, for instance) and we usually
      # match the response object to test outcome.
      # render_template is RSpec Rails matcher
      expect(response).to render_template(:new)
    end

    it 'assigns a new campaign instance variable' do
      # GIVEN: nothing (just the Rails controller)

      # WHEN: we make a GET request to the 'new' action
      get :new

      # THEN: we assign a new 'Campaign' instance variable
      # assigns: is a method that will look for isntance variables defined in
      # your controller's action
      # be_a_new: is an RSpec Rails matcher that will ensure that what you're
      # matching is a new instance of the class you pass in, which is
      # 'Campaign' in this case.
      # @campaign instance variable should be a new instance of the Campaign
      # class
      expect(assigns(:campaign)).to be_a_new(Campaign)
    end
  end

  describe '#create' do
    context 'with valid attributes' do
      # you can define methods within 'describes' and 'contexts'. Keep in mind
      # that those methods will only be accessibly for examples that are within
      # those 'describes' and 'contexts' or nested 'describes' or 'contexts'.
      def valid_request
        post :create, params: {
                        campaign: FactoryGirl.attributes_for(:campaign)
                      }
      end
      it 'creates a new campaign in the database' do
        count_before = Campaign.count
        valid_request
        count_after = Campaign.count
        expect(count_after).to eq(count_before + 1)
      end

      it 'redirects to the campaign show page' do
        # GIVEN: nothing (just the Rails controller)

        # WHEN: we make a POST request with valid params
        valid_request

        # THEN: we get redirected to the campaign's show page
        expect(response).to redirect_to(campaign_path(Campaign.last))
      end

      it 'sets a flash message' do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    context 'with invalid attributes' do
      def invalid_request
        post :create, params: {
                        campaign:
                          FactoryGirl.attributes_for(:campaign, title: nil)
                      }
      end
      it 'does not create a record in the database' do
        count_before = Campaign.count
        invalid_request
        count_after = Campaign.count
        expect(count_after).to eq(count_before)
      end
      it 'renders the new template' do
        invalid_request
        expect(response).to render_template(:new)
      end
    end
  end
end
