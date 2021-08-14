class PaymentsController < ApplicationController
  def create
    # 1. form방식으로 넘겼을 때 Create액션
      # order = Order.find(params[:order_id])
      # if params[:imp_uid].present?
      #   response = Iamport.payment(params[:imp_uid])
      #   Payment.create(
      #     order_id: order,
      #     response: response,
      #     imp_uid: response["response"]["imp_uid"],
      #     merchant_uid: response["response"]["merchant_uid"],
      #     amount: response["response"]["amount"]
      #   )
      #   order.update(status: "processed")
      #   flash[:notice] = "결제 되었습니다"
      # else
      #   error_msg = params[:error_msg]
      #   order.update(status: "failed")
      #   flash[:notice] = error_msg
      # end
      # redirect_to "/orders"

    # 2. Ajax로 넘겼을 때 Create 액션
      order = Order.find(params[:order_id])
 
      if params[:imp_uid].present?
        response = Iamport.payment(params[:imp_uid])
        Payment.create(
          order_id: order,
          response: response,
          imp_uid: response["response"]["imp_uid"],
          merchant_uid: response["response"]["merchant_uid"],
          amount: response["response"]["amount"]
        )
        order.update(status: "processed")
        @notice = "결제 되었습니다"

      else
        error_msg = params[:error_msg]
        order.update(status: "failed")
        @notice = error_msg
      end
      
      respond_to do |format|
        format.js
      end
      
  end
end
