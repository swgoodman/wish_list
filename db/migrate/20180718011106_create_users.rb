class CreateUsers < ActiveRecord::Migration
  def change
    creat_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      
      t.timestamps null: false
  end
end
