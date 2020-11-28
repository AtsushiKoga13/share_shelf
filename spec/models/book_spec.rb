require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:user) { create(:user) }
  let(:book) { user.books.build(title: "test_title") }

  it "is valid with title" do
    expect(book).to be_valid
  end

  it "title should be present" do
    book.title = "  "
    expect(book).not_to be_valid
  end

  it "user id should be present" do
    book.user_id = nil
    expect(book).not_to be_valid
  end

  it "order should be most recent first" do
    second_book = user.books.create(title: "second_title")
    expect(user.books.first).to eq second_book
  end

  it "associated books should be destroyed" do
    book.save
    expect { user.destroy }.to change(Book, :count).from(1).to(0)
  end
end
