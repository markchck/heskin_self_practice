ActiveAdmin.register Pack do
	scope :all
	scope -> {"공개"}, :published, default:true
	scope -> {"비공개"}, :unpublished
	
  form do |pack|
    pack.inputs do
      pack.input :image, as: :file
      pack.input :product_name
      pack.input :desc
      pack.input :price, hint: "실제 판매 가격을 입력해주세요"
			pack.input :is_publish
    end
    pack.actions
  end

  show do
    attributes_table do
      row :id
      row :image do |pack|
        if pack.image.attached?
            image_tag url_for(pack.image)
        else
            "이미지 없음"
        end
      end
      row :product_name
      row :desc
      row :price do |pack|
        number_to_currency(pack.price)
      end
			row :is_publish
    end
  end

  index do
    selectable_column
    id_column

    column :image do |pack|
      if pack.image.attached?
        image_tag url_for(pack.image), class: "small_img"
      else
        "이미지 없음"
      end
    end
    column :product_name
    column :desc
    column :price do |pack|
      number_to_currency(pack.price)
    end
		column :is_publish
    actions
  end
end