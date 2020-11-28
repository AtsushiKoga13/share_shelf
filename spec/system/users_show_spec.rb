require 'rails_helper'

RSpec.describe 'Users show page', type: :system, js: true do
  let!(:user) { create(:user) }
  let(:image_url) { "https://placehold.jp/85x120.png" }

  before do
    user.books.create(title:"テストタイトル",image: image_url,tag_id:1)
    visit login_path
    fill_in "session_email", with: user.email
    fill_in "session_password", with: user.password
    click_button "Log in"
  end

  it "can change book tag" do
    expect(page).to have_content "test_user"
    expect(page).to have_selector("img[src$='test_user_post_image.jpg']")
    expect(page).to have_selector("img[src$='#{image_url}']")
    find('img', id: "book1" ).click
    expect(page).to have_content "感想"
    click_button "読みたい本棚に移動"
    click_button "閉じる"
    click_button "読み終わり"
    expect(page).not_to have_selector("img[src$='#{image_url}']")
    click_button "読みたい"
    expect(page).to have_selector("img[src$='#{image_url}']")
  end

  it "can add and edit impression" do
    expect(page).to have_content "test_user"
    expect(page).to have_selector("img[src$='test_user_post_image.jpg']")
    expect(page).to have_selector("img[src$='#{image_url}']")
    find('img', id: "book1" ).click
    click_on '感想を追加する'
    fill_in "Impression", with: "テストインプレッション"
    click_button "登録"
    expect(page).to have_content "テストインプレッション"
    click_on '感想を編集する'
    fill_in "Impression", with: "エディットインプレッション"
    click_button "登録"
    expect(page).to have_content "エディットインプレッション"
  end
end