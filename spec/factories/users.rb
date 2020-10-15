FactoryBot.define do
  factory :user do
    name { "test_user" }
    email { "test@test.test" }
    password { "password" }
    password_confirmation { "password" }
  end
end
