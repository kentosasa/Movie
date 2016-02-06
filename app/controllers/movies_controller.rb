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
    ids = Comment.pluck(:movie_id).uniq
    @movies = Movie.where(id: ids).sort_by{|o| ids.index(o.id)}
    @movies = @movies[0..19]
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def search
    @q = params[:q]
    @movies = Movie.where("title like '%" + @q + "%'").order("created_at desc")
  end
end
