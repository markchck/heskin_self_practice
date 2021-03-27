class AddIsPublishToPack < ActiveRecord::Migration[5.2]
  def change
    add_column :packs, :is_publish, :boolean, default: true
  end
end
