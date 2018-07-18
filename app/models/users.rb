class User < ActiveRecord::Base

  has_secure_password

  has_many :item
  has_many :category, through: :item
end
