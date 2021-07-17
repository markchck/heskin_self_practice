class OrdersController < ApplicationController
  def create
    order = Order.create(user_id: current_user.id)
    carts = Cart.where(id: params[:cart_id])

    carts.each do |cart|
      order.order_items.create(pack_id: cart.pack_id, quantity: cart.quantity)
      #이게 뭐하는 중인지 모를 수 있는데 order_item 만들기 위한 빌드업이네.
      #order_item을 만들어야 주문자(order)와 팩(pack)을 이어주니까.
      #주문자와 팩이 있어야 주문 정보 페이지를 만들 수 있으니까.
    end
    carts.destroy_all
    redirect_to "/orders/#{order.id}"
    #다른 페이지로 넘어가는게 꼭 a 태그, form태그만 있는게 아니구나! (redirect to 써서 컨트롤러 단계에서도 가능)
  end

  def show
    @order = Order.find(params[:id])

  end
end
