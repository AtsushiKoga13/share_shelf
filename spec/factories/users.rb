FactoryBot.define do
  factory :user do
    name { "test_user" }
    email { "test@test.test" }
    password { "password" }
    password_confirmation { "password" }
    after(:build) do |user|
      user.image.attach(io: File.open(Rails.root.join('spec/factories/images/test_user_post_image.jpg')), 
                        filename: 'test_user_post_image.jpg', 
                        content_type: 'image/jpg')
    end
  end
end
