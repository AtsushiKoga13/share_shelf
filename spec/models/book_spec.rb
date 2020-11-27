require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:user) { create(:user) }

  it "is valid with title" do
    book = user.books.build( title: "test_title" )
    expect(book).to be_valid
  end

  it "title should be present" do
    book = user.books.build( title: "  " )
    expect(book).not_to be_valid
  end

  it "user id should be present" do
    book = user.books.build( title: "test_title" )
    book.user_id = nil
    expect(book).not_to be_valid
  end

  it "order should be most recent first" do
    first_book = user.books.create( title: "first_title" )
    second_book = user.books.create( title: "second_title" )
    expect(user.books.first).to eq second_book
  end

  it "associated books should be destroyed" do
    book = user.books.create( title: "test_title" )
    expect{ user.destroy }.to change{ Book.count }.from(1).to(0)
  end
end
