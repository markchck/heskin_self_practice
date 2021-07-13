class PacksController < ApplicationController
	before_action :authenticate_user!
	def index
    @pack = Pack.published

  end
	
  def show
    @pack = Pack.find(params[:id])
  end
end