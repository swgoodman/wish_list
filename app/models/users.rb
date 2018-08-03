require_relative "concerns/slugifiable.rb"

class User < ActiveRecord::Base

# Activerecord macro that uses bcrypt(gem) password encryption.
  has_secure_password

# Gives class 'Slug' functionality.
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

# Class Associations.
  has_many :items
  has_many :categories, through: :items
end
