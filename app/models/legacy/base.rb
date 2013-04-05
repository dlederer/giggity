class Legacy::Base < ActiveRecord::Base
  self.abstract_class = true
  self.establish_connection "legacy"
  
  require 'core_extensions'
  require 'acts_as_importable'
  
  acts_as_importable
end