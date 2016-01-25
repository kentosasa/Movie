# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  year        :integer
#  description :text
#  story       :text
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class MoviesController < ApplicationController
  def index
    @movies = Movie.feed.limit(10)
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
