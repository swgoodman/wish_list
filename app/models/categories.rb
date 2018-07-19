require_relative "concerns/slugifiable.rb"

class Category < ActiveRecord::Base

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

  has_many :item
end
