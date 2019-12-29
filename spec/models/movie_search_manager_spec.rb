require 'rails_helper'
#require 'remote_api_stub'
#include RemoteAPIStub

def prepare_client_with_invalid_criteria
  before do
    search_client_object = object_double(MovieSearchClient.new)

    allow(search_client_object)
        .to receive(:get_themoviedb_list)
                .and_return([])
    allow(search_client_object)
        .to receive(:get_themoviedb_details)
                .and_return({}.with_indifferent_access)
    allow(search_client_object)
        .to receive(:get_imdb_details)
                .and_return({}.with_indifferent_access)

    search_client_class = class_double("MovieSearchClient")
                              .as_stubbed_const(transfer_nested_constants: true)
    allow(search_client_class).to receive(:new).and_return(search_client_object)
  end

  let(:criteria) { {title: ""} }
  let(:manager) { MovieSearchManager.new criteria }
  let(:result) do
    manager.perform_search
  end
end

def prepare_client_with_valid_criteria
  valid_movies_list = [{"popularity"        => 35.37,
                        "vote_count"        => 7382,
                        "video"             => false,
                        "poster_path"       => "/2y4dmgWYRMYXdD1UyJVcn2HSd1D.jpg",
                        "id"                => 280,
                        "adult"             => false,
                        "backdrop_path"     => "/d9AqtruwS8nljKjL5aYzM42hQJr.jpg",
                        "original_language" => "en",
                        "original_title"    => "Terminator 2: Judgment Day",
                        "genre_ids"         => [28, 878, 53],
                        "title"             => "Terminator 2: Judgment Day",
                        "vote_average"      => 8,
                        "overview"          =>
                            "Nearly 10 years have passed since Sarah Connor was targeted for termination by a cyborg "\
"from the future. Now her son, John, the future leader of the resistance, is the target for a newer, more deadly "\
"terminator. Once again, the resistance has managed to send a protector back to attempt to save John and his mother "\
"Sarah.",
                        "release_date"      => "1991-07-03"}]

  valid_themoviedb_details = {"adult"                 => false,
                              "backdrop_path"         => "/d9AqtruwS8nljKjL5aYzM42hQJr.jpg",
                              "belongs_to_collection" =>
                                  {"id"            => 528,
                                   "name"          => "The Terminator Collection",
                                   "poster_path"   => "/vxiKtcxAJxHhlg2H1X8y7zcM3k6.jpg",
                                   "backdrop_path" => "/cpmbkwSxZnKO69V82A9a34tvk2E.jpg"},
                              "budget"                => 102000000,
                              "genres"                =>
                                  [{"id" => 28, "name" => "Action"},
                                   {"id" => 53, "name" => "Thriller"},
                                   {"id" => 878, "name" => "Science Fiction"}],
                              "homepage"              => "",
                              "id"                    => 280,
                              "imdb_id"               => "tt0103064",
                              "original_language"     => "en",
                              "original_title"        => "Terminator 2: Judgment Day",
                              "overview"              =>
                                  "Some overview here",
                              "popularity"            => 35.37,
                              "poster_path"           => "/2y4dmgWYRMYXdD1UyJVcn2HSd1D.jpg",
                              "production_companies"  =>
                                  [{"id"             => 61409,
                                    "logo_path"      => nil,
                                    "name"           => "T2 Productions",
                                    "origin_country" => ""},
                                   {"id"             => 574,
                                    "logo_path"      => "/iB6GjNVHs5hOqcEYt2rcjBqIjki.png",
                                    "name"           => "Lightstorm Entertainment",
                                    "origin_country" => "US"},
                                   {"id"             => 1280,
                                    "logo_path"      => nil,
                                    "name"           => "Pacific Western",
                                    "origin_country" => "US"},
                                   {"id"             => 104,
                                    "logo_path"      => "/9aotxauvc9685tq9pTcRJszuT06.png",
                                    "name"           => "Canal+",
                                    "origin_country" => "FR"},
                                   {"id"             => 275,
                                    "logo_path"      => "/2MxNWlN5b3UXt1OfmznsWEQzFwq.png",
                                    "name"           => "Carolco Pictures",
                                    "origin_country" => "US"},
                                   {"id"             => 559,
                                    "logo_path"      => "/jqWioYeGSyTLuHth0141bTGvu6H.png",
                                    "name"           => "TriStar Pictures",
                                    "origin_country" => "US"}],
                              "production_countries"  =>
                                  [{"iso_3166_1" => "US", "name" => "United States of America"}],
                              "release_date"          => "1991-07-03",
                              "revenue"               => 520000000,
                              "runtime"               => 137,
                              "spoken_languages"      =>
                                  [{"iso_639_1" => "en", "name" => "English"},
                                   {"iso_639_1" => "es", "name" => "Español"}],
                              "status"                => "Released",
                              "tagline"               => "It's nothing personal.",
                              "title"                 => "Terminator 2: Judgment Day",
                              "video"                 => false,
                              "vote_average"          => 8.0,
                              "vote_count"            => 7386}

  valid_omdb_details = {"Title"      => "Terminator 2: Judgment Day",
                        "Year"       => "1991",
                        "Rated"      => "R",
                        "Released"   => "03 Jul 1991",
                        "Runtime"    => "137 min",
                        "Genre"      => "Action, Sci-Fi",
                        "Director"   => "James Cameron",
                        "Writer"     => "James Cameron, William Wisher",
                        "Actors"     =>
                            "Arnold Schwarzenegger, Linda Hamilton, Edward Furlong, Robert Patrick",
                        "Plot"       =>
                            "A cyborg, identical to the one who failed to kill Sarah Connor, must now protect her "\
"teenage son, John Connor, from a more advanced and powerful cyborg.",
                        "Language"   => "English, Spanish",
                        "Country"    => "USA",
                        "Awards"     => "Won 4 Oscars. Another 31 wins & 33 nominations.",
                        "Poster"     =>
                            "https://m.media-amazon.com/images/M/MV5BMGU2NzRmZjUtOGUxYS00ZjdjLWEwZWItY2NlM2JhNjkxN"\
"TFmXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg",
                        "Ratings"    =>
                            [{"Source" => "Internet Movie Database", "Value" => "8.5/10"},
                             {"Source" => "Rotten Tomatoes", "Value" => "93%"},
                             {"Source" => "Metacritic", "Value" => "75/100"}],
                        "Metascore"  => "75",
                        "imdbRating" => "8.5",
                        "imdbVotes"  => "938,871",
                        "imdbID"     => "tt0103064",
                        "Type"       => "movie",
                        "DVD"        => "31 Mar 1998",
                        "BoxOffice"  => "$198,116,802",
                        "Production" => "TriStar Pictures",
                        "Website"    => "N/A",
                        "Response"   => "True"}
  before do
    themoviedb_id        = 280
    omdb_id              = "tt0103064"
    search_client_object = object_double(MovieSearchClient.new)

    allow(search_client_object)
        .to receive(:get_themoviedb_list)
                .and_return(valid_movies_list.map(&:with_indifferent_access))
    allow(search_client_object)
        .to receive(:get_themoviedb_details)
                .with(themoviedb_id)
                .and_return(valid_themoviedb_details.with_indifferent_access)
    allow(search_client_object)
        .to receive(:get_imdb_details)
                .with(omdb_id)
                .and_return(valid_omdb_details.with_indifferent_access)


    search_client_class = class_double("MovieSearchClient")
                              .as_stubbed_const(transfer_nested_constants: true)
    allow(search_client_class).to receive(:new).and_return(search_client_object)
  end

  let(:criteria) { {title: "Terminator"} }
  let(:manager) { MovieSearchManager.new criteria }
  let(:result) { pp manager.perform_search }
end

def prepare_formatter_with_valid_criteria
  prepare_client_with_valid_criteria
  response       = [{themoviedb: {title:        "Terminator 2: Judgment Day",
                                  adult:        false,
                                  status:       "Released",
                                  release_date: "1991-07-03"},
                     imdb:       {Genre:      "Action, Sci-Fi",
                                  Plot:       "A cyborg, identical to the one who failed to kill Sarah Connor, must "\
"now protect her teenage son, John Connor, from a more advanced and powerful cyborg.",
                                  Metascore:  "75",
                                  imdbRating: "8.5"}}]
  formatted_data = [{title:        "Terminator 2: Judgment Day",
                     adult:        false,
                     status:       "Released",
                     release_date: "1991-07-03",
                     genre:        "Action, Sci-Fi",
                     plot:         "A cyborg, identical to the one who failed to kill Sarah Connor, must "\
"now protect her teenage son, John Connor, from a more advanced and powerful cyborg.",
                     metascore:    "75",
                     imdb_rating:  "8.5"}]
  before do
    formatter = object_double(MoviesDataFormatter.new(response))
    allow(formatter).to receive(:format_movies_response).and_return(formatted_data)
  end
end

def prepare_formatter_with_invalid_criteria
  prepare_client_with_invalid_criteria
  before do
    formatter = object_double(MoviesDataFormatter.new([]))
    allow(formatter).to receive(:format_movies_response).and_return([])
  end
end

RSpec.describe MovieSearchManager, type: :model do
  context "#initialize" do
    context "#with" do
      let(:criteria) { {title: "Terminator"} }

      it "should return a new instance of MovieSearchClient" do
        client = MovieSearchManager.new criteria
        expect(client).to be_an_instance_of(MovieSearchManager)
        expect(client.response).to be nil
      end
    end
  end

  context "#perform_search" do

    context "with valid criteria" do
      prepare_client_with_valid_criteria

      it "should return array of hashes" do
        expect(result).to be_an_instance_of(Array)
        expect(result[0]).to be_an_instance_of(Hash)
      end

      it "should have themoviedb part" do
        expect(result[0]).to have_key(:themoviedb)
      end

      it "should have imdb part" do
        expect(result[0]).to have_key(:imdb)
      end

      it "should populate manager.response" do
        expect(result).to eq manager.response
      end
    end

    context "with invalid criteria" do

      prepare_client_with_invalid_criteria

      it "should return empty array" do
        expect(result).to be_an_instance_of(Array)
        expect(result.count).to be 0
      end

      it "should populate manager.response" do
        expect(result).to eq manager.response
      end
    end
  end

  context "#format_data" do
    context "with response" do
      prepare_formatter_with_valid_criteria

      let(:format_result) do
        manager.perform_search
        manager.format_data
      end

      it "should return array of hashes" do
        expect(format_result).to be_an_instance_of(Array)
        expect(format_result[0]).to be_an_instance_of(Hash)
      end

    end

    context "with response == nil " do
      let(:criteria) { {title: "Terminator"} }
      let(:manager) { MovieSearchManager.new criteria }

      it "should raise an exception" do
        expect { manager.format_data }.to raise_error(RuntimeError)
      end
    end

    context "with response == []" do

      prepare_formatter_with_invalid_criteria

      let(:formatted_data) do
        manager.perform_search
        manager.format_data
      end
      it "should return empty array" do
        expect(formatted_data).to eq []
      end
    end
  end
end
