ActiveAdmin.register Pack do
  form do |pack|
    pack.inputs do
      pack.input :image, as: :file
      pack.input :product_name
      pack.input :desc
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
    actions
  end
end