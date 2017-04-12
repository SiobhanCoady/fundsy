# Factories are used as a source to always generate a valid model or a valid
# set of attributes. This is why, when setting up your factory, you should always
# ensure that the generated model or attributes are valid, taking into account
# any validations you may have in your model. The factory will actually invoke
# the model to generate the record, so it will invoke validations as well. So
# this factory will use the 'User' model to generate user records.

# In Rails Console, run: FactoryGirl.create(:user)
# 100.times { FactoryGirl.create(:user) }

FactoryGirl.define do
  factory :user do
    # You can put a piece of code as the value for the field in Factory Girl.
    # This will make FactoryGirl invoke the piece of code every time you use it.
    first_name      { Faker::Name.first_name }
    last_name       { Faker::Name.last_name }
    # If faker code is not in brackets (as below), every generated last name will
    # be the same. Put in brackets to generate new name every time.
    # last_name  Faker::Name.last_name

    # The sequence method in FactoryGirl will generate a unique number that
    # increments every time you invoke FactoryGirl on this model. It is a good
    # method to use to ensure that a given generated string will be unique.
    sequence(:email) { |n| Faker::Internet.email.gsub('@', "#{n}@") }
    password         'supersecret'
  end
end
