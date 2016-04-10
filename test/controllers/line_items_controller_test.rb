require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post :create, product_id: products(:ruby).id
    end
    assert_redirected_to store_url
  end

  test "should create line item via ajax" do 
    assert_difference('LineItem.count') do
      xhr :post, :create, product_id: products(:ruby).id
    end

    assert_response :success
    assert_select_jquery :html, '#cart' do
      assert_select 'tr#current_item td', /Programming Ruby 1.9/
    end
  end

  test "should show line_item" do
    get :show, id: @line_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line_item
    assert_response :success
  end

  test "should update line_item" do
    patch :update, id: @line_item, line_item: { product_id: @line_item.product_id }
    assert_redirected_to line_item_path(assigns(:line_item))
  end

  test "should destroy line_item" do
    @cart = carts(:one)
    @product = products(:ruby)
    @cart.add_product(@product.id).save!
    assert_difference('LineItem.count', -1) do
      delete :destroy, id: @cart.line_items[0]
    end
      
    assert_redirected_to store_url
  end

  test "should destroy line item via ajax" do 
    @cart = carts(:one)
    @product1 = products(:ruby)
    @product2 = products(:ruby2)
    @cart.add_product(@product1.id).save!
    @cart.add_product(@product2.id).save!
    assert_difference('LineItem.count', -1) do
      xhr :delete, :destroy, id: @cart.line_items[0]
    end

    #по книге стр.221 удаление без авторизации невозможно(рушит AJAX удаление)
    #поэтому разрешили удаление без авторизации line_items_controller.rb:6
    logout
    assert_difference('LineItem.count', -1) do
      xhr :delete, :destroy, id: @cart.line_items[1]
    end
  end
end