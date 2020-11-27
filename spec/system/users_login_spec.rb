require 'rails_helper'

RSpec.describe 'Users login', type: :system, js: true do
  let!(:user) { create(:user, :a) }

  context "when value is valid" do
    it "can login" do
      visit login_path
      fill_in "session_email", with: user.email
      fill_in "session_password", with: user.password
      click_button "Log in"
      expect(page).to have_content "Share Shelf"
    end
  end
end