class CreateOrdersTable < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.boolean :completed?
      t.datetime :order_date
      t.string :food_item
      t.integer :quantity 
      t.integer :user_id
      t.integer :total
    end 
  end
end


