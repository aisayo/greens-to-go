class CreateMenuItemsTable < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :item
      t.integer :price
      t.string :description
    end 
  end
end

