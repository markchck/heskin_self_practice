ActiveAdmin.register User do
  index do
    selectable_column
    id_column

    column :name
    column :phone
    column :post_code
    column :email
		column "장바구니 유무" do |user|
				user.carts.present?
		end
    actions do |user|
			a "장바구니", href: "/admin/users/#{user.id}/carts"
		end
  end
end
