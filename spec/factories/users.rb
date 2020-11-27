FactoryBot.define do
  factory :user , class: 'User' do
    name { "test_user" }
    email { "test@test.test" }
    password { "password" }
    password_confirmation { "password" }
    avatar { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/images/test_user_post_image.jpg')) }
  end

  factory :other_user, class: 'User' do
    name { "other_user" }
    email { "other@other.other" }
    password { "password" }
    password_confirmation { "password" }
    avatar { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/images/test_image_1.jpg')) }
  end
end
