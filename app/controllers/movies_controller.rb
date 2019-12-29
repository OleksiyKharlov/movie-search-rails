class MoviesController < ApplicationController

  INDEX_PERMITTED_PARAMS = %i(title format)
  INDEX_REQUIRED_PARAMS  = %i(title)

  before_action :process_params, only: :index
  before_action :check_required_params, only: :index


  def index
    manager = MovieSearchManager.new(@processed_params)
    manager.perform_search
    render json: {movies: manager.format_data}
  end

  private

  def process_params
    @processed_params = params.permit(*INDEX_PERMITTED_PARAMS).to_h.with_indifferent_access
  end

  def check_required_params
    INDEX_REQUIRED_PARAMS.each do |param|
      params.require param
    end
  end

end