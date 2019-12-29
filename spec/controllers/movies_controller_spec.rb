require 'rails_helper'

formatted_data = [{title:        "Terminator Genisys",
                   adult:        false,
                   status:       "Released",
                   release_date: "2015-06-23",
                   genre:        "Action, Adventure, Sci-Fi",
                   plot:         "Some plot here",
                   metascore:    "84",
                   imdb_rating:  "8.0"}]


RSpec.describe MoviesController, type: :controller do
  describe "GET #index" do
    let(:params) { {title: "Terminator"} }
    before do
      manager = object_double(MovieSearchManager.new(params.with_indifferent_access))
      allow(manager).to receive(:perform_search)
      allow(manager).to receive(:format_data).and_return(formatted_data)
      manager_class = class_double("MovieSearchManager").as_stubbed_const(transfer_nested_constants: true)
      expect(manager_class).to receive(:new).with(params).and_return(manager)
      get :index, params: params
    end
    it "has a 200 status code" do
      expect(response.status).to eq(200)
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
