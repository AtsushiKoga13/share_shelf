require 'rails_helper'

RSpec.describe 'Users edit', type: :system, js: true do
  let!(:user) { create(:user) }
  let(:email) { "test@test.test" }
  let(:password) { "password" }

  before do
    user.image = fixture_file_upload(File.join(Rails.root, "spec/factories/images/test_user_post_image.jpg"))
    visit login_path
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_button "Log in"
  end

  context "when value is valid" do
    it "can edit" do
      visit edit_user_path(1)
      expect(page).to have_content "Update your profile picture"
      fill_in "Name", with: "edit_name"
      fill_in "Email", with: "edit_email@e.e"
      click_button "Save changes"
      expect(page).to have_content "Share Shelf"
      expect(page).to have_content "edit_name"
      expect(page).to have_content "edit_email@e.e"
    end
  end

  context "when value is invalid" do
    it "can not edit" do
      visit edit_user_path(1)
      expect(page).to have_content "Update your profile picture"
      fill_in "Name", with: ""
      fill_in "Email", with: "edit_email@e.e"
      click_button "Save changes"
      expect(page).to have_content "Update your profile picture"
      expect(page).to have_content "error"
    end
  end

  context "when image file is uploaded" do
    it "can edit profile image" do
      visit edit_user_path(1)
      image_path = File.join(Rails.root, "spec/factories/images/test_image_1.jpg")
      attach_file "user[image]", image_path
      expect(page).to have_selector("img[alt$='test_image_1.jpg']")
      click_button "Save changes"
      expect(page).to have_selector("img[alt$='test_image_1.jpg']")
    end
  end

  context "when large image file is uploaded" do
    it "can not edit profile image" do
      visit edit_user_path(1)
      image_path = File.join(Rails.root, "spec/factories/images/large_size_image.png")
      page.accept_alert "Maximum file size is 5MB. Please choose a smaller file." do
        attach_file "user[image]", image_path
      end
      expect(page).to have_content "Update your profile picture"
      expect(find('#submit_button')).to be_disabled
    end
  end
end