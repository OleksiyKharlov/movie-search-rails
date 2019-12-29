require 'rails_helper'
require 'remote_api_stub'
include RemoteAPIStub

REQUIRED_THEMOVIEDB_KEYS = %w(adult release_date status title)
REQUIRED_IMDB_KEYS = %w(Genre Metascore Plot imdbRating)

RSpec.describe MovieSearchClient, type: :model do
  context "#initalize" do
    it "should return a new instance of MovieSearchClient" do
      client = MovieSearchClient.new
      expect(client).to be_an_instance_of(MovieSearchClient)
    end
  end

  let(:movie_search_client) { MovieSearchClient.new }

  context "#get_themoviedb_list" do
    context "with valid criteria" do
      let(:criteria) { {title: "Terminator"} }
      let(:result) do
        stub_movies_list_request
        movie_search_client.get_themoviedb_list criteria
      end

      it "should return array of hashes" do
        expect(result).to be_an_instance_of(Array)
        expect(result[0]).to be_an_instance_of(HashWithIndifferentAccess)
      end

      it "should return array of hashes with key :id" do
        expect(result.all? { |el| el.has_key?(:id) }).to be true
      end


    end

    context "with invalid criteria" do
      let(:criteria) { "" }
      let(:result) do
        stub_movies_list_request criteria
        movie_search_client.get_themoviedb_list({title: criteria})
      end

      it "should return empty array" do
        expect(result).to be_an_instance_of(Array)
        expect(result.count).to be 0
      end
    end
  end

  context "#get_themoviedb_details" do
    context "with valid movie_id" do
      let(:movie_id) { 280 }
      let(:result) do
        stub_themoviedb_details movie_id
        movie_search_client.get_themoviedb_details movie_id
      end

      it "should return a Hash" do
        expect(result).to be_an_instance_of(HashWithIndifferentAccess)
      end

      it "should return a Hash with required fields" do
        REQUIRED_THEMOVIEDB_KEYS.each do |key|
          expect(result).to have_key key
        end
      end

    end

    context "with invalid movie id" do
      let(:movie_id) { "goo" }
      let(:result) do
        stub_themoviedb_details movie_id
        movie_search_client.get_themoviedb_details movie_id
      end

      it "should return a Hash" do
        expect(result).to be_an_instance_of(HashWithIndifferentAccess)
      end

      it "should return a Hash WITHOUT required fields" do
        REQUIRED_THEMOVIEDB_KEYS.each do |key|
          expect(result).not_to have_key key
        end
      end
    end
  end

  context "#get_imdb_details" do
    context "with valid id" do
      let(:i) {"tt0103064"}
      let(:result) do
        stub_omdb_details i
        movie_search_client.get_imdb_details i
      end

      it "should return a Hash" do
        expect(result).to be_an_instance_of(HashWithIndifferentAccess)
      end

      it "should return a Hash with required fields" do
        REQUIRED_IMDB_KEYS.each do |key|
          expect(result).to have_key key
        end
      end
    end

    context "with invalid id" do
      let(:i) {"goo"}
      let(:result) do
        stub_omdb_details i
        movie_search_client.get_imdb_details i
      end

      it "should return a Hash" do
        expect(result).to be_an_instance_of(HashWithIndifferentAccess)
      end

      it "should return a Hash with required fields" do
        REQUIRED_IMDB_KEYS.each do |key|
          expect(result).not_to have_key key
        end
      end
    end
  end
end
