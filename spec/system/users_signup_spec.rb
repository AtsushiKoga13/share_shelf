require 'rails_helper'

RSpec.describe 'Users signup', type: :system do
  let(:name) { "test_user" }
  let(:email) { "test@test.test" }
  let(:password) { "password" }
  let(:password_confirmation) { "password" }
  let(:avatar) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/images/test_user_post_image.jpg')) }

  before do
    visit new_user_path
    fill_in "user_name", with: name
    fill_in "user_email", with: email
    fill_in "user_password", with: password
    fill_in "user_password_confirmation", with: password_confirmation
    image_path = File.join(Rails.root, "spec/factories/images/test_user_post_image.jpg")
    attach_file "user_avatar", image_path
    click_button "Create my account"
  end

  context "when value is valid" do
    it "create user" do
      expect(User.count).to eq 1
    end
  end

  context "when password is blank" do
    let!(:password) { "" }

    it "doesn't create user" do
      expect(User.count).to eq 0
      expect(page).to have_content "パスワードを入力してください"
    end
  end

  context "when confirmation password is not match" do
    let!(:password_confirmation) { "foobar" }

    it "doesn't create user" do
      expect(User.count).to eq 0
      expect(page).to have_content "パスワード確認とパスワードの入力が一致しません"
    end
  end

  context "when email has already been taken" do
    it "doesn't create user" do
      visit new_user_path
      fill_in "user_name", with: name
      fill_in "user_email", with: email
      fill_in "user_password", with: password
      fill_in "user_password_confirmation", with: password_confirmation
      image_path = File.join(Rails.root, "spec/factories/images/test_user_post_image.jpg")
      attach_file "user_avatar", image_path
      click_button "Create my account"
      expect(User.count).to eq 1
      expect(page).to have_content "メールアドレスはすでに存在します"
    end
  end
end
