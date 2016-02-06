class MetasController < ApplicationController
  def show
    @meta = Meta.find(params[:id])
    view_context.set_title("#{@meta.name}")
  end
end
