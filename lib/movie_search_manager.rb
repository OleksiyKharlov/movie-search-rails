class MovieSearchManager

  attr_reader :response

  def initialize criteria, options = {}
    @search_client = MovieSearchClient.new
    @criteria      = criteria
  end


  def perform_search
    list_response = @search_client.get_themoviedb_list @criteria
    @response = list_response.map { |movie| get_id movie }.compact.map do |movie_id|
      themoviedb_details = @search_client.get_themoviedb_details movie_id
      imdb_id = get_imdb_id(themoviedb_details)
      {themoviedb: themoviedb_details,
       imdb:       @search_client.get_imdb_details(imdb_id)}
    end
  end

  def format_data
    raise "No response yet, call perform_search first" if response.nil?
    @formatted_data ||= MoviesDataFormatter.new(@response).format_movies_response
  end

  private

  # The following methods were added in case remote API key for this param changes.

  def get_imdb_id themoviedb_details
    themoviedb_details&.[](:imdb_id)
  end

  def get_id movie
    movie&.[](:id)
  end

end