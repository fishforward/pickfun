require 'test_helper'

class PicTagsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pic_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pic_tag" do
    assert_difference('PicTag.count') do
      post :create, :pic_tag => { }
    end

    assert_redirected_to pic_tag_path(assigns(:pic_tag))
  end

  test "should show pic_tag" do
    get :show, :id => pic_tags(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => pic_tags(:one).to_param
    assert_response :success
  end

  test "should update pic_tag" do
    put :update, :id => pic_tags(:one).to_param, :pic_tag => { }
    assert_redirected_to pic_tag_path(assigns(:pic_tag))
  end

  test "should destroy pic_tag" do
    assert_difference('PicTag.count', -1) do
      delete :destroy, :id => pic_tags(:one).to_param
    end

    assert_redirected_to pic_tags_path
  end
end
