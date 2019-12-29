class MovieSearchClient

  THEMOVIEDB_API_URL = 'https://api.themoviedb.org/3'.freeze
  THEMOVIEDB_API_KEY = ENV['THEMOVIEDB_API_KEY']
  OMDB_API_URL       = 'http://omdbapi.com/'.freeze
  OMDB_API_KEY       = ENV['OMDB_API_KEY']

  def initialize
    @client           = RestClient
    @max_movies_range = 0...3
    @client.log       = Logger.new(STDOUT)
  end

  def get_themoviedb_list criteria
    url     = "#{THEMOVIEDB_API_URL}/search/movie"
    headers = {params: prepare_list_params(criteria)}

    get_formatted(url, headers, :movies_list_from_response)
  end

  def get_themoviedb_details movie_id
    url     = "#{THEMOVIEDB_API_URL}/movie/#{movie_id}"
    headers = {params: {api_key: THEMOVIEDB_API_KEY}}
    get_formatted(url, headers, :movie_details_from_response)
  end

  def get_imdb_details imdb_id
    base_url_string = OMDB_API_URL
    headers         = {params: {apikey: OMDB_API_KEY, i: imdb_id}}
    get_formatted(base_url_string, headers, :movie_details_from_response)
  end


  private

  def get_formatted base_url_string, headers, formatter_method
    response = safe_get_request(base_url_string, headers)
    send(formatter_method, response)
  end

  def safe_get_request url, headers
    @client.get url, headers
  end

  def movie_details_from_response response
    JSON.parse(response.body).with_indifferent_access
  end

  def prepare_list_params criteria
    result = {api_key: THEMOVIEDB_API_KEY}
    result.merge(prepare_criteria(criteria)).stringify_keys
  end

  def prepare_criteria criteria
    raise "title is mandatory" unless criteria.has_key? :title
    criteria[:query] = Array(criteria.delete(:title))
                           &.map(&:to_s)
                           &.map { |el| el.split('+') }
                           &.flatten
                           &.join(' ')
    criteria
  end

  def movies_list_from_response response
    result = JSON.parse(response.body)
                 &.[]('results')
                 &.[](@max_movies_range)
                 &.map(&:with_indifferent_access)
    Array(result)
  end


end