require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'requires an email' do
      # GIVEN: a new user object without an email
      u = User.new

      # WHEN: we invoke validations
      u.valid?

      # THEN: we get an error on the email field
      expect(u.errors.messages).to have_key(:email)
    end

    it 'requires a unique email' do
      # GIVEN:
      s = FactoryGirl.create(:user)
      u = User.new email: s.email

      # WHEN: we invoke validation
      u.valid?

      # THEN: We have an error on the 'email' field
      expect(u.errors.messages).to have_key(:email)

    end
  end
end
