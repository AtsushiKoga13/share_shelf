require 'rails_helper'

RSpec.describe 'Users edit', type: :system, js: true do
  let!(:user) { create(:user) }
  let(:edit_name) { "edit_name" }
  let(:edit_email) { "edit_email@e.e" }

  before do
    visit login_path
    fill_in "session_email", with: "test@test.test"
    fill_in "session_password", with: user.password
    click_button "Log in"
    visit edit_user_path(1)
    fill_in "user_name", with: edit_name
    fill_in "user_email", with: edit_email
    fill_in "user_password", with: user.password
    fill_in "user_password_confirmation", with: user.password
  end

  context "when value is valid" do
    it "can edit" do
      click_button "変更を保存する"
      expect(page).to have_content "Share Shelf"
      expect(page).to have_content "edit_name"
    end
  end

  context "when name is invalid" do
    let(:edit_name) { "" }

    it "can not edit" do
      click_button "変更を保存する"
      expect(page).to have_content "Update your profile"
      expect(page).to have_content "名前を入力してください"
    end
  end

  context "when email is invalid" do
    let(:edit_email) { "" }

    it "can not edit" do
      click_button "変更を保存する"
      expect(page).to have_content "Update your profile"
      expect(page).to have_content "メールアドレスを入力してください"
    end
  end

  context "when image file is uploaded" do
    it "can edit profile image" do
      image_path = File.join(Rails.root, "spec/factories/images/test_image_1.jpg")
      attach_file "user[avatar]", image_path
      expect(page).to have_selector("img[alt$='test_image_1.jpg']")
      click_button "変更を保存する"
      expect(page).to have_content "Share Shelf"
      expect(page).to have_selector("img[src$='test_image_1.jpg']")
    end
  end

  context "when large image file is uploaded" do
    it "can not edit profile image" do
      visit edit_user_path(1)
      image_path = File.join(Rails.root, "spec/factories/images/large_size_image.png")
      page.accept_alert "Maximum file size is 5MB. Please choose a smaller file." do
        attach_file "user[avatar]", image_path
      end
      expect(page).to have_content "Update your profile"
      expect(find('#submit_button')).to be_disabled
    end
  end
end