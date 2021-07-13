ActiveAdmin.register Pack do
	skip_before_action :verify_authenticity_token, raise: false
	
	scope :all, default: true
	scope :published
	scope :un_published
	
	batch_action :published do |ids|
		@packs = Pack.where(id: ids)
		@packs.each do |pack|
			pack.update(is_publish: true)
		end
		flash[:notice] = "#{@packs.count}개의 마스크 팩이 공개 처리되었습니다."
		redirect_back(fallback_location: root_path)
	end
	
	batch_action :unpublish do |ids|
		@packs = Pack.where(id: ids)
		@packs.each do |pack|
			pack.update(is_publish: false)
		end
		flash[:notice] = "#{@packs.count}개의 마스크 팩이 비공개 처리되었습니다."
		redirect_to collection_path, alert: "The posts have been flagged."
		# redirect_back(fallback_location: root_path)
	end
	
	# batch_action :flag do |ids|
	# 	batch_action_collection.find(ids).each do |pack|
	# 		pack.update(is_publish: true)
	# 		pack.is_publish :true
	# 	end
	# 	redirect_to collection_path, alert: "The posts have been flagged."
	# end
	
	# batch_action :unflag do |ids|
	# 	batch_action_collection.find(ids).each do |pack|
	# 		pack.update(is_publish: false)
	# 	end
	# 	redirect_to collection_path, alert: "The posts have been unflagged."
	# end

	
	
	
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
            image_tag url_for("https://dummyimage.com/640x360/fff/aaa")
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
        image_tag url_for("https://dummyimage.com/640x360/fff/aaa"), class: "small_img"
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