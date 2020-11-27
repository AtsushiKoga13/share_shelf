require 'rails_helper'

RSpec.describe 'Users show page', type: :system, js: true do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:other_user) }

  before do
    other_user.active_relationships.create(followed_id: user.id)
    visit login_path
    fill_in "session_email", with: user.email
    fill_in "session_password", with: user.password
    click_button "Log in"
  end

  it "book post is displayed" do
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
    fill_in 'keyword', with: 'テストタイトル'
    click_on "検索"
    click_on '読み終わり本棚へ保存'
    click_link 'MyPage'
    expect(page).to have_selector("img[src$='test_user_post_image.jpg']")
    click_link 'Log out'
    fill_in "session_email", with: other_user.email
    fill_in "session_password", with: other_user.password
    click_button "Log in"
    expect(page).to have_selector("img[src$='test_user_post_image.jpg']")
    expect(page).to have_content "test_userさんが「テストタイトル」を本棚に登録しました。"
  end

  it "follow post is displayed" do
    click_link 'Users'
    click_button "Follow"
    click_link 'MyPage'
    click_link 'user_followings'
    expect(page).to have_content other_user.name
    expect(page).to have_selector("img[src$='test_image_1.jpg']")
    click_link 'Log out'
    fill_in "session_email", with: other_user.email
    fill_in "session_password", with: other_user.password
    click_button "Log in"
    expect(page).to have_selector("img[src$='test_user_post_image.jpg']")
    expect(page).to have_content "test_userさんにフォローされました。"
  end
end