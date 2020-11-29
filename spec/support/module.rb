module RakutenApiWebmock
  def rakuten_api_webmock()
    body_json = JSON.generate({ 'Items' => [
      {
        "title" => "テストタイトル",
        "mediumImageUrl" => "/test_user_post_image.jpg",
        "titleKana" => "テストタイトル",
      },
    ] })
    WebMock.enable!
    WebMock.stub_request(:get, ENV["RAKUTEN_MOCK_URL"]).
      with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'RakutenWebService SDK for Ruby v1.13.0(ruby-2.6.6 [x86_64-linux])',
        }
      ).
      to_return(status: 200, body: body_json, headers: {})
  end
end
