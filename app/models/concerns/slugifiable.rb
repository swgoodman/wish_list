module Slugifiable

# Slug Method - Adds 'slug' functionality to shorten and format usernames.
  module InstanceMethods
    def slug
        self.name.gsub(" ", "-").downcase
    end
  end

# Find By Slug Method - Gives ability to search class by slug.
  module ClassMethods
    def find_by_slug(slug)
      self.all.find{ |instance| instance.slug == slug }
    end
  end
end
