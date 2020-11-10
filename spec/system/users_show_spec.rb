require 'rails_helper'

RSpec.describe 'Users show page', type: :system, js: true do
  let!(:user) { create(:user) }
  let(:email) { "test@test.test" }
  let(:password) { "password" }

  before do
    visit login_path
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_button "Log in"
  end

  it "has user info" do
    click_link 'User'
    expect(page).to have_content "test_user"
    expect(page).to have_selector("img[src$='test_user_post_image.jpg']")
  end
end