FactoryBot.define do
  factory :user do
    name { "test_user" }
    email { "test@test.test" }
    password { "password" }
    password_confirmation { "password" }
    avatar { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/images/test_user_post_image.jpg')) }
  end
end
