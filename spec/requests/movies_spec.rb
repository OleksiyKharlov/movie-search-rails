require 'rails_helper'
include RemoteAPIStub

EXPECTED_RESPONSE_KEYS = %w(adult genre imdb_rating metascore plot release_date status title)
ROOT_KEY = "movies"


RSpec.describe "Movies", type: :request do
  describe "GET /movies" do

    context "if works correctly" do
      before do
        stub_movies_list_request
        stub_themoviedb_details
        stub_omdb_details

        get '/api/v1/movies?title=Terminator'
      end

      it "should return 200" do
        expect(response).to have_http_status(200)
      end

      it "should return JSON" do
        expect(response.headers["Content-Type"]).to include('application/json')
        expect(response.body).to be_an_instance_of(String)
      end

      it "should comply with desired JSON structure" do
        result_hash = JSON.parse(response.body)
        expect(result_hash).to have_key ROOT_KEY
        expect(result_hash[ROOT_KEY]).to be_an_instance_of(Array)
        EXPECTED_RESPONSE_KEYS.each do |key|
          expect(result_hash["movies"][0]).to have_key(key)
        end
        expect(result_hash["movies"][0].keys.sort).to eql(EXPECTED_RESPONSE_KEYS)
      end
    end

  end


end
