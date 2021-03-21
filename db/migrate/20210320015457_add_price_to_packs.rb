class AddPriceToPacks < ActiveRecord::Migration[5.2]
  def change
    add_column :packs, :price, :integer
  end
end
