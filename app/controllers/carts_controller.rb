class CartsController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@carts = current_user.carts.order(created_at: :desc)
		
				
		currentCarts = current_user.carts
		@sumCart = 0 
		currentCarts.each do |cart|
			@sumCart = @sumCart + cart.quantity*cart.pack.price
		end
		
		if @sumCart > 15000
			@shipping_fee = 0
		else
			@shipping_fee = 2500
		end
	end
	
  def create
		repeatCart = current_user.carts.find_by(pack_id: params[:pack_id])
		if repeatCart.present?
			repeatCart.update(
				pack_id: repeatCart.pack_id,
				user_id: repeatCart.user_id,
				quantity: repeatCart.quantity + (params[:quantity]).to_i
			)
		else
			Cart.create(
				pack_id: params[:pack_id],
				user_id: current_user.id,
				quantity: params[:quantity]
			)
		end
		
		flash[:notice] = "성공적으로 담겼습니다. 장바구니로 이동하시겠습니까?"
		redirect_back(fallback_location: root_path)
  end
	
	def destroy
		@cart = Cart.find(params[:id])
		@cart.destroy
		redirect_back(fallback_location: root_path)
	end
end