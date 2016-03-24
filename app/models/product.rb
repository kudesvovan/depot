class Product < ActiveRecord::Base
	validates :title, :description, :image_url, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :title, uniqueness: true
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(GIF|PNG|JPG)\Z}i,
		message: 'must be a URL for GIF, PNG or JPG image'
	}
	validates :description , length: {minimum: 10,  message: " shouldn't be less than 10 characters"}

	def self.latest
		Product.order(:updated_at).last
	end
end
