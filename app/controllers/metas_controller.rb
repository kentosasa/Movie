class MetasController < ApplicationController
  def show
    @meta = Meta.find(params[:id])
    set_meta_tags title: "#{@meta.name}"
  end
end
