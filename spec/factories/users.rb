FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { "user" }
    role { "user" }
    password { "password" }
    avatar { 'abvatar' }
  end
end