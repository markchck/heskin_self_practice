class PaymentsController < ApplicationController
  def create
    # response = Iamport.payment(params["imp_uid"])

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

      flash[:notice] = "결제 되었습니다"
    else
      error_msg = params[:error_msg]
      order.update(status: "failed")
      flash[:notice] = error_msg
    end
    
    redirect_to "/orders"
  end
end
