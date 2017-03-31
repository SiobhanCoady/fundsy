require 'rails_helper'

RSpec.describe Campaign, type: :model do
  # whenever you want to start a new group of test examples, you can use either
  # 'describe' or 'context'. They are functionally the same, but depending on
  # the context, one may be better than the other.
  describe 'Validations' do

    # whenever you want to define a test example, you use 'it' or 'specify'.
    # They are functionally the same. Make sure to give a good description about
    # your test.
    it 'requires a title' do
      # GIVEN: We have a new campaign object
      c = Campaign.new

      # WHEN: We invoke validations
      c.valid?

      # THEN: There is a validation error
      # when we want to test outcome in RSpec, we always start with 'expect'
      # RSpec can use 'matching', which is more sophisticated than simple
      # equality check.
      # expect(c).to be_invalid
      expect(c.errors).to have_key(:title)
    end

    it 'requires a unique title' do
      # GIVEN: We have a new campaign object and we have an existing campaign
      # record in the database (with same title as the new one)
      Campaign.create({ title: 'abc',
                        body: 'xyz',
                        goal: 10,
                        end_date: 60.days.from_now })
      c = Campaign.new({ title: 'abc' })

      # WHEN: We invoke validations
      c.valid?

      # THEN: Expect c to have errors on the title field
      expect(c.errors).to have_key(:title)
    end
  end
end
