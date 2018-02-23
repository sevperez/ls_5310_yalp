module Sluggable
  extend ActiveSupport::Concern
  
  included do
    after_validation :build_slug
    class_attribute :slug_key
  end
  
  def build_slug
    current_key = self.send(self.class.slug_key.to_sym)
    
    return if self.slug || current_key.nil?
    
    slug = current_key.gsub(/[^a-z0-9\s]/i, "").split(/\s/).join("-").downcase
    counter = 2
    
    while self.class.find_by(slug: slug) && self.class.find_by(slug: slug) != self
      slug.gsub!(/(-[0-9]+)$/, "")
      slug += "-#{counter}"
      counter += 1
    end
    
    self.slug = slug
  end
  
  def to_param
    self.slug
  end
  
  module ClassMethods
    def set_slug_key(key)
      self.slug_key = key
    end
  end
end
