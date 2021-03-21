class HomeController < ApplicationController
  def index
    @pack = Pack.all
  end

  def show
    @pack = Pack.find(params[:id])
  end
end
