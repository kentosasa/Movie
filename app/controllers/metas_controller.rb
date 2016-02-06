class MetasController < ApplicationController
  def show
    @meta = Meta.find(params[:id])
  end
end
