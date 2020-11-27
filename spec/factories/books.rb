FactoryBot.define do
  factory :book , class: 'Book' do
    title { "テストタイトル" }
    user_id { 1 }
    image { "https://placehold.jp/85x120.png" }
  end
end
