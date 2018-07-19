class Item < ActiveRecord::Base

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

  belongs_to :user
  belongs_to :category
end
