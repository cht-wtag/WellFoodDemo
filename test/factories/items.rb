FactoryGirl.define do
  factory :item do
    name {Faker::Hipster.sentence}
    description {Faker::Hipster.paragraph}
    association(:user)

  end
end
