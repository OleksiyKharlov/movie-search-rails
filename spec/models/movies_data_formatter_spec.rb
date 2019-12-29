require 'rails_helper'

EXPECTED_RESPONSE_KEYS = %i(adult genre imdb_rating metascore plot release_date status title)

movie_details = [{themoviedb: {title:        "Terminator 2: Judgment Day",
                               adult:        false,
                               status:       "Released",
                               release_date: "1991-07-03"},
                  imdb:       {Genre:      "Action, Sci-Fi",
                               Plot:       "A cyborg, identical to the one who failed to kill Sarah Connor, must "\
"now protect her teenage son, John Connor, from a more advanced and powerful cyborg.",
                               Metascore:  "75",
                               imdbRating: "8.5"}}]

RSpec.describe MoviesDataFormatter, type: :model do
  context "#initialize" do
    context "with valid movie_details" do
      let(:new_data_formatter) { MoviesDataFormatter.new(movie_details) }
      it "should be an instance of MoviesDataFormatter" do
        expect(new_data_formatter).to be_an_instance_of MoviesDataFormatter
      end
    end
  end

  context "#format_movies_response" do
    context "with valid movie_details" do
      let(:formatter) { MoviesDataFormatter.new(movie_details) }
      let(:format_result) { formatter.format_movies_response }
      it "should return an array of hashes" do
        expect(format_result).to be_an_instance_of Array
        expect(format_result[0]).to be_an_instance_of Hash
      end

      it "should have required keys" do
        format_result.each do |element|
          expect(element.keys.map(&:to_s).sort).to eq EXPECTED_RESPONSE_KEYS
        end
      end
    end

    context "with invalid movie_details" do
      let(:formatter) { MoviesDataFormatter.new(Object.new) }
      it "should raise an exception" do
        expect { formatter.format_movies_response }.to raise_error
      end
    end
  end
end
