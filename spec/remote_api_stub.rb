module RemoteAPIStub
  def stub_movies_list_request criteria = 'Terminator'
    query_params           = {}
    query_params[:api_key] = MovieSearchClient::THEMOVIEDB_API_KEY
    query_params[:query]   = criteria
    query_params           = query_params.stringify_keys.map { |k, v| "#{k}=#{v}" }.join('&')
    response_hash          = criteria.present? ? {
        page:          1,
        total_results: 1,
        total_pages:   1,
        results:       [{popularity:        40.799,
                         vote_count:        7375,
                         video:             false,
                         poster_path:       "/2y4dmgWYRMYXdD1UyJVcn2HSd1D.jpg",
                         id:                280,
                         adult:             false,
                         backdrop_path:     "/d9AqtruwS8nljKjL5aYzM42hQJr.jpg",
                         original_language: "en",
                         original_title:    "Terminator 2: Judgment Day",
                         genre_ids:         [28, 878, 53],
                         title:             "Terminator 2: Judgment Day",
                         vote_average:      8,
                         overview:          "Nearly 10 years have passed since Sarah Connor was targeted for"\
" termination by a cyborg from the future. Now her son, John, the future leader of the resistance, is the target"\
" for a newer, more deadly terminator. Once again, the resistance has managed to send a protector back to attempt"\
" to save John and his mother Sarah.",
                         release_date:      "1991-07-03"
                        }]} : {"errors": ["query must be provided"]}

    response_headers = {
        "access-control-allow-methods"  => "GET, HEAD, POST, PUT, DELETE, OPTIONS",
        "access-control-allow-origin"   => "*",
        "access-control-expose-headers" => "ETag, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset, "\
"Retry-After, Content-Length, Content-Range",
        "cache-control"                 => "public, max-age=120",
        "content-encoding"              => "gzip",
        "content-type"                  => "application/json;charset=utf-8",
        "date"                          => "Sat, 28 Dec 2019 16:48:01 GMT",
        "server"                        => "openresty",
        "status"                        => 200,
        "vary"                          => "Accept-Encoding",
        "via"                           => "1.1 7210fed509d8e341021bffe29c62787c.cloudfront.net (CloudFront)",
        "x-amz-cf-id"                   => "nIqglsOBOYUW8n-jt2d8iwUs-6-uzWqaWcQsPD3_9_DP6RXX2_7fIQ==",
        "x-amz-cf-pop"                  => "WAW50-C1",
        "x-cache"                       => "Miss from cloudfront",
    }

    request_headers = {
        'Accept'          => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Host'            => 'api.themoviedb.org',
        'User-Agent'      => 'rest-client/2.1.0 (darwin19.2.0 x86_64) ruby/2.6.5p114'
    }

    stub_request(:get, "https://api.themoviedb.org/3/search/movie?#{query_params}").
        with(headers: request_headers).
        to_return(status: 200, body: JSON.generate(response_hash), headers: response_headers)
    stub_request(:get, "https://api.themoviedb.org/3/search/movie?#{query_params}&format=json").
        with(headers: request_headers).
        to_return(status: 200, body: JSON.generate(response_hash), headers: response_headers)
    #puts "Request should have been stubbed"
  end

  def stub_themoviedb_details movie_id = 280
    body_hash = (movie_id.is_a?(Integer) and movie_id > 0) ?
                    {
                        "adult"                 => false,
                        "backdrop_path"         => "/d9AqtruwS8nljKjL5aYzM42hQJr.jpg",
                        "belongs_to_collection" => {
                            "id"            => 528,
                            "name"          => "The Terminator Collection",
                            "poster_path"   => "/vxiKtcxAJxHhlg2H1X8y7zcM3k6.jpg",
                            "backdrop_path" => "/cpmbkwSxZnKO69V82A9a34tvk2E.jpg"
                        },
                        "budget"                => 102000000,
                        "genres"                => [
                            {
                                "id"   => 28,
                                "name" => "Action"
                            },
                            {
                                "id"   => 53,
                                "name" => "Thriller"
                            },
                            {
                                "id"   => 878,
                                "name" => "Science Fiction"
                            }
                        ],
                        "homepage"              => "",
                        "id"                    => 280,
                        "imdb_id"               => "tt0103064",
                        "original_language"     => "en",
                        "original_title"        => "Terminator 2: Judgment Day",
                        "overview"              => "Nearly 10 years have passed since Sarah Connor was targeted for "\
"termination by a cyborg from the future. Now her son, John, the future leader of the resistance, is the target for a"\
" newer, more deadly terminator. Once again, the resistance has managed to send a protector back to attempt to save "\
"John and his mother Sarah.",
                        "popularity"            => 40.799,
                        "poster_path"           => "/2y4dmgWYRMYXdD1UyJVcn2HSd1D.jpg",
                        "production_companies"  => [
                            {
                                "id"             => 61409,
                                "logo_path"      => nil,
                                "name"           => "T2 Productions",
                                "origin_country" => ""
                            },
                            {
                                "id"             => 574,
                                "logo_path"      => "/iB6GjNVHs5hOqcEYt2rcjBqIjki.png",
                                "name"           => "Lightstorm Entertainment",
                                "origin_country" => "US"
                            },
                            {
                                "id"             => 1280,
                                "logo_path"      => nil,
                                "name"           => "Pacific Western",
                                "origin_country" => "US"
                            },
                            {
                                "id"             => 104,
                                "logo_path"      => "/9aotxauvc9685tq9pTcRJszuT06.png",
                                "name"           => "Canal+",
                                "origin_country" => "FR"
                            },
                            {
                                "id"             => 275,
                                "logo_path"      => "/2MxNWlN5b3UXt1OfmznsWEQzFwq.png",
                                "name"           => "Carolco Pictures",
                                "origin_country" => "US"
                            },
                            {
                                "id"             => 559,
                                "logo_path"      => "/jqWioYeGSyTLuHth0141bTGvu6H.png",
                                "name"           => "TriStar Pictures",
                                "origin_country" => "US"
                            }
                        ],
                        "production_countries"  => [
                            {
                                "iso_3166_1" => "US",
                                "name"       => "United States of America"
                            }
                        ],
                        "release_date"          => "1991-07-03",
                        "revenue"               => 520000000,
                        "runtime"               => 137,
                        "spoken_languages"      => [
                            {
                                "iso_639_1" => "en",
                                "name"      => "English"
                            },
                            {
                                "iso_639_1" => "es",
                                "name"      => "Español"
                            }
                        ],
                        "status"                => "Released",
                        "tagline"               => "It's nothing personal.",
                        "title"                 => "Terminator 2: Judgment Day",
                        "video"                 => false,
                        "vote_average"          => 8,
                        "vote_count"            => 7380
                    } : {
        "status_code":    34,
        "status_message": "The resource you requested could not be found."
    }

    response_headers =
        {
            "access-control-allow-methods"  => "GET, HEAD, POST, PUT, DELETE, OPTIONS",
            "access-control-allow-origin"   => "*",
            "access-control-expose-headers" => "ETag, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset, "\
"Retry-After, Content-Length, Content-Range",
            "cache-control"                 => "public, max-age=14400",
            "content-encoding"              => "gzip",
            "content-type"                  => "application/json;charset=utf-8",
            "date"                          => "Sat, 28 Dec 2019 17:04:32 GMT",
            "etag"                          => "W/\"975ae91cb0afbe883f9826a465c859c1",
            "server"                        => "openresty",
            "status"                        => 200,
            "vary"                          => "Accept-Encoding",
            "via"                           => "1.1 dce4c8b7b9f77858bc00bb5154e30f3c.cloudfront.net (CloudFront)",
            "x-amz-cf-id"                   => "w5WIeUHxmTtwIxJqlbsXqaGzSBHIKqYokW-lZB5lCVo7VyRhy17GMQ==",
            "x-amz-cf-pop"                  => "WAW50-C1",
            "x-cache"                       => "Miss from cloudfront",
            "x-memc"                        => "HIT",
            "x-memc-age"                    => 8091,
            "x-memc-expires"                => 6309,
            "x-memc-key"                    => "677975ebf1f53c241cfdbe42db58d565",
        }

    stub_request(:get, "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{MovieSearchClient::THEMOVIEDB_API_KEY}").
        with(
            headers: {
                'Accept'          => '*/*',
                'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Host'            => 'api.themoviedb.org',
                'User-Agent'      => 'rest-client/2.1.0 (darwin19.2.0 x86_64) ruby/2.6.5p114'
            }).
        to_return(status:  200,
                  body:    JSON.generate(body_hash),
                  headers: response_headers)
  end

  def stub_omdb_details i="tt0103064"
    is_valid_id = (i =~ /^tt\d{7}$/)
    response_body = is_valid_id ? {
        "Title"      => "Terminator 2: Judgment Day",
        "Year"       => "1991",
        "Rated"      => "R",
        "Released"   => "03 Jul 1991",
        "Runtime"    => "137 min",
        "Genre"      => "Action, Sci-Fi",
        "Director"   => "James Cameron",
        "Writer"     => "James Cameron, William Wisher",
        "Actors"     => "Arnold Schwarzenegger, Linda Hamilton, Edward Furlong, Robert Patrick",
        "Plot"       => "A cyborg, identical to the one who failed to kill Sarah Connor, must now protect her teenage"\
" son, John Connor, from a more advanced and powerful cyborg.",
        "Language"   => "English, Spanish",
        "Country"    => "USA",
        "Awards"     => "Won 4 Oscars. Another 31 wins & 33 nominations.",
        "Poster"     => "https://m.media-amazon.com/images/M/MV5BMGU2NzRmZjUtOGUxYS00ZjdjLWEwZWItY2NlM2JhNjkxNTFmXkE"\
"yXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg",
        "Ratings"    => [
            {
                "Source" => "Internet Movie Database",
                "Value"  => "8.5/10"
            },
            {
                "Source" => "Rotten Tomatoes",
                "Value"  => "93%"
            },
            {
                "Source" => "Metacritic",
                "Value"  => "75/100"
            }
        ],
        "Metascore"  => "75",
        "imdbRating" => "8.5",
        "imdbVotes"  => "938,871",
        "imdbID"     => "tt0103064",
        "Type"       => "movie",
        "DVD"        => "31 Mar 1998",
        "BoxOffice"  => "$198,116,802",
        "Production" => "TriStar Pictures",
        "Website"    => "N/A",
        "Response"   => "True"
    } : {
        "Response" => "False",
        "Error"    => "Incorrect IMDb ID."
    }

    response_headers = {
        "Access-Control-Allow-Origin" => "*",
        "Cache-Control"               => "public, max-age=3600",
        "CF-Cache-Status"             => "DYNAMIC",
        "CF-RAY"                      => "54c5372b791d8aba-KBP",
        "Connection"                  => "keep-alive",
        "Content-Encoding"            => "gzip",
        "Content-Type"                => "application/json; charset=utf-8",
        "Date"                        => "Sat, 28 Dec 2019 17:22:17 GMT",
        "Expires"                     => "Sat, 28 Dec 2019 18:22:17 GMT",
        "Last-Modified"               => "Sat, 28 Dec 2019 17:22:17 GMT",
        "Server"                      => "cloudflare",
        "Transfer-Encoding"           => "chunked",
        "Vary"                        => "*",
        "X-AspNet-Version"            => "4.0.30319",
        "X-Powered-By"                => "ASP.NET",
    }

    stub_request(:get, "http://omdbapi.com/?apikey=#{MovieSearchClient::OMDB_API_KEY}&i=#{i}").
        with(
            headers: {
                'Accept'          => '*/*',
                'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Host'            => 'omdbapi.com',
                'User-Agent'      => 'rest-client/2.1.0 (darwin19.2.0 x86_64) ruby/2.6.5p114'
            }).
        to_return(status: 200, body: JSON.generate(response_body), headers: response_headers)
  end

end