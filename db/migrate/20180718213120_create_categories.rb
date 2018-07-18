class CreateCategories < ActiveRecord::Migration
  def change
    create_table :category do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
