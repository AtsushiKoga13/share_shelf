6.times do |n|
  User.create!(
    name: "テストユーザー#{n + 1}",
    email: "test#{n + 1}@test.com",
    password: "password",
    avatar: File.open('./spec/factories/images/test_user_post_image.jpg')
  )
end

User.all.each do |user|
  book = user.books.create(title:"テストタイトル", image:"https://placehold.jp/85x120.png", tag_id:1)
  book.create_impression(content:"test impression")
  user.posts.create(content: "#{user.name}さんが「テストタイトル」を本棚に登録しました。",
                    image: "https://placehold.jp/85x120.png",
                    name: "テストユーザー",
                    post_type: 2)
end

5.times do |n|
  User.first.active_relationships.create(followed_id: User.find(n + 2).id)
  User.first.passive_relationships.create(follower_id: User.find(n + 2).id)
end