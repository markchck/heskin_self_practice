ActiveAdmin.register Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :status, :name, :phone, :email, :post_code, :address
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :status, :name, :phone, :email, :post_code, :address]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  scope :all
  scope -> {"결제 전"}, :before_payment
  scope -> {"배송중"}, :processed
  scope -> {"배송 완료"}, :completed
  scope -> {"결제 취소"}, :failed

  filter :name
  filter :phone
  filter :post_code
  filter :address
  filter :email
  filter :user_email_cont, label: "사용자 이메일로 검색"
  filter :packs_product_name_cont, label: "팩이름으로 검색"

  batch_action :cancelled, form: {
    cancel_reason: :textarea
  } do |ids, inputs|
    orders = Order.where(id: ids)
    orders.each do |order|
      order.payments.each do |t|
        body = {
            imp_uid: t.imp_uid,
            merchant_uid: t.merchant_uid,
            amount: t.amount 
        }
        result = Iamport.cancel(body)

        if result["response"]["status"] == "cancelled"
          order.update(cancel_reason: inputs["cancel_reason"], status: :cancelled)
        end

      end
      
    end
    flash[:notice] = "성공적으로 환불되었습니다."
    redirect_to collection_path    
  end
  
  # index액션
  index do
    selectable_column
    id_column
    column :user do |order|
      a order.user.email, href: "/admin/users/#{order.user.id}"
    end

    column :address
    column :email
    column :name
    column :phone
    column :post_code
    column :status
    column :created_at
    actions
  end
  
  show do
    attributes_table do
      row :address
      row :email
      row :phone
      row :name
      row :post_code
      row :status
    end

    panel "주문한 팩" do

      table_for order.order_items do

        column "팩이름" do |item|
          item.pack.product_name
        end
        
        column "가격" do |item|
          number_to_currency(item.quantity * item.pack.price)
        end

        column :quantity do |item|
          item.quantity
        end

        column "링크" do |item|
          a "이동", href: "/admin/packs/#{item.pack.id}", target: "_blank"
        end

      end

    end
    active_admin_comments
  end

  sidebar "Details", only: :show do
    attributes_table_for order.payments do
      
      row :amount do |payment|
        number_to_currency(payment.amount)
      end
      row "imp_uid"
      row :merchant_uid     
      row "링크" do |payment|
        a "영수증보기", href: payment.response["response"]["receipt_url"], target: "_blank"
      end
    end
  end
end