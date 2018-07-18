class CreateItems < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :link
      t.integer :price
      t.integer :category_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
