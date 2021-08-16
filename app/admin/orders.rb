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


end
