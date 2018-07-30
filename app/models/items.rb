require_relative "concerns/slugifiable.rb"

class Item < ActiveRecord::Base

# Gives class 'Slug' functionality.
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

# Class Associations.
  belongs_to :user
  belongs_to :category
end
