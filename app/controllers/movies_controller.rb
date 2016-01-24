class MoviesController < ApplicationController
  def index
    @movie = Movie.find(3326)
  end
end
