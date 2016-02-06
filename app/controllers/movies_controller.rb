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
    movies = Movie.where(id: ids).sort_by{|o| ids.index(o.id)}
    @movies = Kaminari.paginate_array(movies).page(params[:page])
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def search
    @q = params[:q]
    movies = Movie.where("title like '%" + @q + "%'").order("created_at desc")
    @movies = Kaminari.paginate_array(movies).page(params[:page])
  end

  def comment
    @movie = Movie.find(params[:id])
    Comment.create(movie_id: params[:id], user_name: params[:user_name][0], text: params[:text][0])
    render action: :show
  end
end
