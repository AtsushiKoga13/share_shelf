6.times do |n|
  User.create!(
    name: "テストユーザー#{n + 1}",
    email: "test#{n + 1}@test.com",
    password: "password",
    avatar: File.open('./spec/factories/images/test_user_post_image.jpg')
  )
end

5.times do |n|
  User.first.active_relationships.create(followed_id: User.find(n + 2).id)
  User.first.passive_relationships.create(follower_id: User.find(n + 2).id)
end

User.all.each do |user|
  user.books.create(title:"プロを目指す人のためのRuby入門",
                    image:"https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/3977/9784774193977.jpg?_ex=120x120",
                    tag_id:1,
                    rakuten_url:"https://books.rakuten.co.jp/rb/15209044/")
  user.posts.create(content: "#{user.name}さんが「プロを目指す人のためのRuby入門」を本棚に登録しました。",
                    image: "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/3977/9784774193977.jpg?_ex=120x120",
                    name: "テストユーザー",
                    post_type: 2)
end

user = User.first
user.books.create(title:"現場で使える Ruby on Rails 5速習実践ガイド",
                  image:"https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/2227/9784839962227.jpg?_ex=120x120",
                  tag_id:1,
                  rakuten_url:"https://books.rakuten.co.jp/rb/15628625/")
user.books.create(title:"Vue.jsのツボとコツがゼッタイにわかる本",
                  image:"https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/6494/9784798056494.jpg?_ex=120x120",
                  tag_id:1,
                  rakuten_url:"https://books.rakuten.co.jp/rb/15831044/")
user.books.create(title:"キタミ式イラストIT塾 基本情報技術者 令和03年",
                  image:"https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/7818/9784297117818.jpg?_ex=120x120",
                  tag_id:1,
                  rakuten_url:"https://books.rakuten.co.jp/rb/16509800/")
user.books.create(title:"うかる！ 基本情報技術者　[午後・アルゴリズム編]　2020年版",
                  image:"https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/5044/9784532415044.jpg?_ex=120x120",
                  tag_id:1,
                  rakuten_url:"https://books.rakuten.co.jp/rb/16098644/")
user.books.create(title:"なっとく！アルゴリズム",
                  image:"https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/3354/9784798143354.jpg?_ex=120x120",
                  tag_id:3,
                  rakuten_url:"https://books.rakuten.co.jp/rb/14605941/")
user.books.create(title:"オブジェクト指向設計実践ガイド",
                  image:"https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/3619/9784774183619.jpg?_ex=120x120",
                  tag_id:3,
                  rakuten_url:"https://books.rakuten.co.jp/rb/14383504/")
user.books.create(title:"Webを支える技術",
                  image:"https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/2043/9784774142043.jpg?_ex=120x120",
                  tag_id:1,
                  rakuten_url:"https://books.rakuten.co.jp/rb/6385779/")
user.books.create(title:"リーダブルコード",
                  image:"https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/5658/9784873115658.jpg?_ex=120x120",
                  tag_id:1,
                  rakuten_url:"https://books.rakuten.co.jp/rb/11753651/")
user.books.create(title:"SQLアンチパターン",
                  image:"https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/5894/9784873115894.jpg?_ex=120x120",
                  tag_id:1,
                  rakuten_url:"https://books.rakuten.co.jp/rb/12185610/")
user.books.create(title:"マスタリングTCP/IP-入門編ー（第6版）",
                  image:"https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/4478/9784274224478.jpg?_ex=120x120",
                  tag_id:2,
                  rakuten_url:"https://books.rakuten.co.jp/rb/16094948/")
user.books.create(title:"新しいLinuxの教科書",
                  image:"https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/0941/9784797380941.jpg?_ex=120x120",
                  tag_id:1,
                  rakuten_url:"https://books.rakuten.co.jp/rb/13241689/")
