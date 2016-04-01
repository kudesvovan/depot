class Order < ActiveRecord::Base
	has_many :line_items, dependent: :destroy
	belongs_to :payment_type

	PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]

	validates :name, :address, :email, presence: true
	validates :payment_type_id, presence: true

	def add_line_items_from_cart(cart)
		cart.line_items.each do |item|
			item.cart_id = nil  #снимаем привязку к корзине, чтобы товарная позиция не исчезла после удаления корзины
			line_items << item
		end
	end
end
