class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.string :post_code

      t.timestamps
    end
  end
end
