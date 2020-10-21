require 'rails_helper'

RSpec.describe 'Users login', type: :system, js: true do
  let!(:user) { create(:user) }
  let(:email) { "test@test.test" }
  let(:password) { "password" }

  context "when value is valid" do
    it "can login" do
      visit login_path
      fill_in "Email", with: email
      fill_in "Password", with: password
      click_button "Log in"
      expect(page).to have_content "Share Shelf"
    end
  end
end