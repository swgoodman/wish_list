class User < ActiveRecord::Base

  has_many :item
  has_many :category, through: :item
end
