require 'faker'

FactoryBot.define do
  factory :person do
   lastname {Faker::Name.last_name}
    firstname {Faker::Name.first_name}
    civility_id {Faker::Name.prefix}
  end
  end

