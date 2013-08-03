require 'test_helper'

class ReportCategoriesControllerTest < ActionController::TestCase
  setup do
    @report_category = report_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:report_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create report_category" do
    assert_difference('ReportCategory.count') do
      post :create, report_category: { description: @report_category.description, icon_url: @report_category.icon_url, name: @report_category.name }
    end

    assert_redirected_to report_category_path(assigns(:report_category))
  end

  test "should show report_category" do
    get :show, id: @report_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @report_category
    assert_response :success
  end

  test "should update report_category" do
    patch :update, id: @report_category, report_category: { description: @report_category.description, icon_url: @report_category.icon_url, name: @report_category.name }
    assert_redirected_to report_category_path(assigns(:report_category))
  end

  test "should destroy report_category" do
    assert_difference('ReportCategory.count', -1) do
      delete :destroy, id: @report_category
    end

    assert_redirected_to report_categories_path
  end
end
