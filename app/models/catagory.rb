class Catagory < ActiveRecord::Base
	has_many :products, dependent: :destroy
	validates_presence_of :cat_type
end

