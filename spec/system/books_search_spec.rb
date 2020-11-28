require 'rails_helper'

RSpec.describe 'Books search', type: :system, js: true do
  let!(:user) { create(:user) }

  before do
    visit login_path
    fill_in "session_email", with: user.email
    fill_in "session_password", with: user.password
    click_button "Log in"
  end

  it "can save book info" do
    rakuten_api_webmock
    click_link 'Search'
    expect(page).to have_content "Search"
    fill_in 'keyword', with: 'テストタイトル'
    click_on "検索"
    expect(page).to have_content "テストタイトル"
    expect(page).to have_selector("img[src$='test_user_post_image.jpg']")
    expect(page).to have_selector("img[alt$='テストタイトル']")
    expect(user.books.count).to eq 0
    expect { click_on '読み終わり本棚へ保存' }.to change { user.books.count }.from(0).to(1)
    click_link 'MyPage'
    expect(page).to have_selector("img[src$='test_user_post_image.jpg']")
  end
end
