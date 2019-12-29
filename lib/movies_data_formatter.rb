class MoviesDataFormatter

  # In case some changes to either remote API or our API specs are made -
  # we'll need to update these reference keys lists or replace them with corresponding mappings.

  THEMOVIEDB_KEYS = %i(title adult status release_date)
  IMDB_KEYS       = %i(Genre Plot Metascore imdbRating)

  def initialize movie_details
    @movie_details = Array(movie_details)
  end

  def format_movies_response
    @movie_details.map do |movie_detals|
      themoviedb_part = format_part :themoviedb, movie_detals
      imdb_part       = format_part :imdb, movie_detals
      themoviedb_part.merge(imdb_part)
    end
  end

  private

  def format_part part_name, movie_details
    movie_details = movie_details[part_name]
    keys          = "#{self.class}::#{part_name.upcase}_KEYS".constantize
    result        = {}
    keys.each do |key|
      result[key.to_s.underscore.to_sym] = movie_details&.[](key).nil? ? 'Not Available' : movie_details&.[](key)
    end
    result
  end
end