require 'rails_helper'

RSpec.describe 'Users show page', type: :system, js: true do
  let!(:user) { create(:user) }

  before do
    visit login_path
    fill_in "session_email", with: user.email
    fill_in "session_password", with: user.password
    click_button "Log in"
  end

  it "has user info" do
    click_link 'MyPage'
    expect(page).to have_content "test_user"
    expect(page).to have_selector("img[src$='test_user_post_image.jpg']")
  end
end