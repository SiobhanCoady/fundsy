# In Rails Console: 100.times { FactoryGirl.create(:campaign) }

FactoryGirl.define do
  factory :campaign do
    sequence(:title)  { |n| "#{Faker::Commerce.product_name} #{n}" }
    body              { Faker::Hipster.paragraph}
    goal              { 10 + rand(100000) }
    end_date          { 60.days.from_now }
  end
end
