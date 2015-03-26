class Product < ActiveRecord::Base
	mount_uploader :image_url, ImageUrlUploader
	has_many :line_items
	belongs_to :user
	belongs_to :catagory

	before_destroy :ensure_not_referenced_by_any_line_item
	validates :title, :description, :image_url, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :title, uniqueness: true
	validates :image_url, allow_blank: true, format: {
	with:
	%r{\.(gif|jpg|png)\Z}i,
	message: 'must be a URL for GIF, JPG or PNG image.'
	}
	

	
	scope :of_cate, lambda { |cate_id|
		where (["catagory_id= ?", cate_id])

	}

# ensure that there are no line items referencing this product
	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'Line Items present')
			return false
		end
	end




end
