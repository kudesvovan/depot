require 'test_helper'
class UsersControllerTest < ActionController::TestCase
  class UsersControllerTest1 < UsersControllerTest 
    setup do
      @user = users(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:users)
    end

    test "shouldn't get index logging oit" do
      logout
      get :index
      assert_redirected_to login_url, notice: "Зарегистрируйтесь, пожалуйста"
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create user" do
      assert_difference('User.count') do
        post :create, user: { name: 'sam', password: 'secret', password_confirmation: 'secret' }
      end

      assert_redirected_to users_path
    end

    test "should show user" do
      get :show, id: @user
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @user
      assert_response :success
    end

    test "shouldn't update user without current password" do
      patch :update, id: @user, user: { name: @user.name, current_password: 'no secret', password: 'new_secret', password_confirmation: 'new_secret' }
      assert_select '#error_explanation ul li', /Current password  is not correct/
    end

    test "should update user" do
      patch :update, id: @user, user: { name: @user.name, current_password: 'secret', password: 'new_secret', password_confirmation: 'new_secret' }
      assert_redirected_to users_path
    end

    test "should destroy user" do
      assert_difference('User.count', -1) do
        delete :destroy, id: @user
      end

      assert_redirected_to users_path
    end
  end
end

class UsersControllerTest < ActionController::TestCase
  class UsersControllerTest2 < UsersControllerTest
    test "if no user in DB any username works to log on" do
      User.delete_all
      logout
      get :index
      assert_redirected_to new_user_path
    end
  end
end