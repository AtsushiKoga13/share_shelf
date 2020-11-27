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
    body_json = JSON.generate({'Items' => [
      {
        "title"=> "テストタイトル",
        "mediumImageUrl"=> "/test_user_post_image.jpg",
        "titleKana"=> "テストタイトル"
      }
    ]}) 
    WebMock.enable!
    WebMock.stub_request(:get, "https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404?affiliateId&applicationId=1023224650998658370&formatVersion=2&title=%E3%83%86%E3%82%B9%E3%83%88%E3%82%BF%E3%82%A4%E3%83%88%E3%83%AB").
    with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'RakutenWebService SDK for Ruby v1.13.0(ruby-2.6.6 [x86_64-linux])'
      }
    ).
    to_return(status: 200, body: body_json , headers: {})
    click_link 'Search'
    expect(page).to have_content "Search"
    fill_in 'keyword', with: 'テストタイトル'
    click_on "検索"
    expect(page).to have_content "テストタイトル"
    expect(page).to have_selector("img[src$='test_user_post_image.jpg']")
    expect(page).to have_selector("img[alt$='テストタイトル']")
    expect(user.books.count).to eq 0
    expect{ click_on '読み終わり本棚へ保存' }.to change{ user.books.count }.from(0).to(1)
    click_link 'MyPage'
    expect(page).to have_selector("img[src$='test_user_post_image.jpg']")
  end
end