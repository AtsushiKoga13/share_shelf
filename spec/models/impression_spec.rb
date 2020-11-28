require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:image_url) { "https://placehold.jp/85x120.png" }
  let(:impression) { user.books.first.build_impression(content: "Lorem ipsum") }

  before do
    user.books.create(title: "テストタイトル", image: image_url, tag_id: 1)
  end

  context "when value is valid" do
    it "is valid" do
      expect(impression).to be_valid
    end
  end

  context "when book_id is nil" do
    it "is invalid" do
      impression.book_id = ""
      expect(impression).not_to be_valid
    end
  end

  context "when content is over 1000" do
    it "is invalid" do
      impression.content = "a" * 1001
      expect(impression).not_to be_valid
    end
  end

  context "when book is destroyed" do
    it "impression is destroyed" do
      impression.save
      expect { user.books.first.destroy }.to change(Impression, :count).by(-1)
    end
  end
end
