require 'rails_helper'

RSpec.describe 'Users signup', type: :system do
  let(:name) { "test_user" }
  let(:email) { "test@test.test" }
  let(:password) { "password" }
  let(:password_confirmation) { "password" }

  before do
    visit new_user_path
    fill_in "Name", with: name
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "Confirmation", with: password_confirmation
    click_button "Create my account"
  end

  context "when value is valid" do
    it "create user" do
      expect(User.count).to eq 1
    end
  end

  context "when password is blank" do
    let!(:password) { "" }

    it "don't create user" do
      expect(User.count).to eq 0
      expect(page).to have_content "error"
    end
  end

  context "when confirmation password is not match" do
    let!(:password_confirmation) { "foobar" }

    it "don't create user" do
      expect(User.count).to eq 0
      expect(page).to have_content "error"
    end
  end

  context "when email has already been taken" do
    it "don't create user" do
      visit new_user_path
      fill_in "Name", with: name
      fill_in "Email", with: email
      fill_in "Password", with: password
      fill_in "Confirmation", with: password_confirmation
      click_button "Create my account"
      expect(User.count).to eq 1
      expect(page).to have_content "error"
    end
  end
end