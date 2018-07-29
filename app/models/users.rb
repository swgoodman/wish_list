require_relative "concerns/slugifiable.rb"

class User < ActiveRecord::Base

  has_secure_password

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

  has_many :items
  has_many :categories, through: :items
end
