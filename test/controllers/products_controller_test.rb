require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
      @update = {
        title: 'Lorem Ipsum',
        description: 'Wibbles are fun!',
        image_url: 'lorem.jpg',
        price: 19.95
      }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)

    assert_select '#side ul li span', /^\d{1,2}\s[A-Za-z]{3}\s\d\d\S\d\d/ #время

    assert_select 'h1', 'Listing products'
    assert_select '.products img', minimum:3
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: @update
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: @update
    assert_redirected_to product_path(assigns(:product))
  end  

  test "can't delete product in cart" do
    @cart = Cart.create
    @product = products(:ruby)
    @cart.add_product(@product.id).save!
    assert_difference('Product.count', 0) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end
