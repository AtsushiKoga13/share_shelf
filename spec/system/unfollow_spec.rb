require 'rails_helper'

RSpec.describe 'Unfollow', type: :system, js: true do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:other_user) }

  before do
    user.passive_relationships.create(follower_id: other_user.id)
    user.active_relationships.create(followed_id: other_user.id)
    visit login_path
    fill_in "session_email", with: user.email
    fill_in "session_password", with: user.password
    click_button "Log in"
  end

  context "user follow other_user" do
    it "can unfollow user" do
      click_link 'Users'
      expect(page).to have_content "Users"
      expect(page).to have_content other_user.name
      expect(page).to have_selector("img[src$='test_image_1.jpg']")
      expect(user.following.count).to eq 1
      click_button "Unfollow"
      expect(user.following.count).to eq 0
      click_link 'MyPage'
      click_link 'user_followings'
      expect(page).not_to have_content other_user.name
      expect(page).not_to have_selector("img[src$='test_image_1.jpg']")
    end
  end

  context "other_user follow user" do
    it "can unfollow user" do
      expect(user.followers.count).to eq 1
      click_link 'MyPage'
      click_link 'user_followers'
      expect(page).to have_content other_user.name
      expect(page).to have_selector("img[src$='test_image_1.jpg']")
    end
  end
end