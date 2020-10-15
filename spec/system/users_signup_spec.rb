require 'rails_helper'

RSpec.describe 'Users signup', type: :system do
  context "when value is valid" do
    it "create user" do
      visit new_user_path
      expect(User.count).to eq 0
      fill_in "Name", with: 'test_user'
      fill_in "Email", with: 'a@example.com'
      fill_in "Password", with: 'password'
      fill_in "Confirmation", with: 'password'
      click_button "Create my account"
      expect(User.count).to eq 1
    end
  end

  context "when value is invalid" do
    it "create user" do
      visit new_user_path
      expect(User.count).to eq 0
      fill_in "Name", with: 'test_user'
      fill_in "Email", with: 'a@example.com'
      fill_in "Password", with: 'password'
      fill_in "Confirmation", with: 'foobar'
      click_button "Create my account"
      expect(page).to have_content "error"
      expect(User.count).to eq 0
    end
  end
end