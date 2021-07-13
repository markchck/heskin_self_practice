class Pack < ApplicationRecord
	has_one_attached :image
	
	
	validates :product_name, :price, presence: true
	validates :is_publish, exclusion: [nil]
	
	scope :published, -> {where(is_publish: true)}
	scope :un_published, -> {where(is_publish: false)}
	
	def Pack.set_dummy_data
		20.times do
			Pack.create(
				product_name: Faker::Bank.unique.name,
				desc: Faker::Superhero.unique.power,
				price: [2000, 3000, 4000].sample
					
			)
		end
	end
	
	has_many :carts, dependent: :destroy
	has_many :users, through: :carts
	
	has_many :order_items, dependent: :destroy
	has_many :orders, through: :order_items
	
	
end
