module RakutenApiWebmock
  def rakuten_api_webmock()
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
  end
end