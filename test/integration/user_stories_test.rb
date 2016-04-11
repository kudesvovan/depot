require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products
  # test "the truth" do
  #   assert true
  # end

  # A user goes to the index page. They select a product, adding it to 
  # their cart, and check out, filling in their details on the checkout form.
  # When they submit, an order is created containing their information, along 
  # with a single line item corresponding to the product they added to their
  # cart.

  test "buying a product" do
  	LineItem.delete_all
  	Order.delete_all
  	ruby_book = products(:ruby)

  	get "/"
  	assert_response :success
  	assert_template "index"

  	xml_http_request :post, "/line_items", product_id: ruby_book.id
  	assert_response :success

  	cart = Cart.find(session[:cart_id])
  	assert_equal 1, cart.line_items.size
  	assert_equal ruby_book, cart.line_items[0].product

  	get "/orders/new"
  	assert_response :success
  	assert_template "new"

  	post_via_redirect "/orders",
  		order: {
  			name: "Dave Thomas",
  			address: "123 The Street",
  			email: "dave@example.com",
  			payment_type_id: 3
  		}
  	assert_response :success
  	assert_template "index"
  	cart = Cart.find(session[:cart_id])
  	assert_equal 0, cart.line_items.size

  	orders = Order.all
  	assert_equal 1, orders.size
  	order = orders[0]

  	assert_equal "Dave Thomas", 			order.name
  	assert_equal "123 The Street", 		order.address
  	assert_equal "dave@example.com",  order.email
  	assert_equal 3, 									order.payment_type_id

  	assert_equal 1, order.line_items.size
  	line_item = order.line_items[0]
  	assert_equal ruby_book, line_item.product

  	mail = ActionMailer::Base.deliveries.last
  	assert_equal ["dave@example.com"], mail.to
  	assert_equal "Vladimir Vasilyev <depot@example.com>", mail[:from].value
  	assert_equal "Подтверждение заказа в Pragmatic Store", mail.subject	
  end

  test "shouldn't get orders index logging out" do
  	get "/"
  	assert_response :success

  	get orders_url
  	assert_redirected_to login_path, notice: "Зарегистрируйтесь, пожалуйста"
  end

=begin
так как только авторизованный user может просматривать корзину, смысла в след тесте нет. См. application_controller before_action, carts_controllrer skip_before_action 	
  test "shoul mail the admin when error occurs" do
  	login_as users(:one)
  	get "/carts/wibble"
  	assert_response :redirect 
  	assert_template "/"

  	mail = ActionMailer::Base.deliveries.last
  	assert_equal ["vladi_it@mail.ru"], mail.to  ## replace mail id
    assert_equal "Vladimir Vasilyev <depot@example.com>", mail[:from].value  
    assert_equal "Исключение в работе приложения Depot", mail.subject
  end
=end
end