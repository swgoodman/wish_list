require_relative "concerns/slugifiable.rb"

class Category < ActiveRecord::Base

# Gives class 'Slug' functionality.
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

# Class Associations.
  has_many :items
end
