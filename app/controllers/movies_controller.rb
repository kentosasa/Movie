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
  before_action :set_meta, only: [:show, :comment]
  before_action :set_breads, only: [:show, :comment]
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
    view_context.set_title("#{@q}の検索結果")
  end

  def comment
    @movie = Movie.find(params[:id])
    Comment.create(movie_id: params[:id], user_name: params[:user_name][0], text: params[:text][0])
    render action: :show
  end

  private
  def set_meta
    movie = Movie.find(params[:id])
    keywords = movie.metas.inject { |metas, meta| "#{metas}, #{meta.name}"}
    keywords = movie.title + keywords.delete!("#")
    set_meta_tags keywords: keywords, og: { vide: "https://www.youtube.com/watch?v=#{movie.youtube.youtube_id}"}
    view_context.set_title("#{movie.title}の予告動画とあらすじ")
  end

  def set_breads
    @breads = []
    movie = Movie.find(params[:id])
    @breads << {url: "#{meta_path(movie.director)}", title: "#{movie.director.name}"} if movie.director.present?
    @breads << {url: "#{movie_path(movie)}", title: "#{movie.title}"}
  end
end
