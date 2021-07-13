ActiveAdmin.register Cart do
belongs_to :user
	index do
    selectable_column
    id_column
    column :pack_id
    column :user_id
		column :quantity
		column "주문금액" do |cart|
			# existed_cart = user.carts.find(pack_id: params[:pack_id])
			number_to_currency(cart.pack.price*cart.quantity)
		end
    actions
  end
end
