require 'rails_helper'

RSpec.describe 'Books search', type: :system, js: true do
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

  it "can search books" do
    click_link 'Search'
    expect(page).to have_content "Search"
    fill_in '検索', with: 'オブジェクト指向'
    click_on "find"
    expect(page).to have_content "オブジェクト指向UIデザイン──使いやすいソフトウェアの原理"
  end
end