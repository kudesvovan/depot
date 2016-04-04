require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  fixtures :orders
  # test "the truth" do
  #   assert true
  # end
	test "add line item to order from cart" do
		@order = orders(:one)
		assert_equal 1, @order.line_items.size
	end
end
