require 'test_helper'

class ReportItemsControllerTest < ActionController::TestCase
  setup do
    @report_item = report_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:report_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create report_item" do
    assert_difference('ReportItem.count') do
      post :create, report_item: { description: @report_item.description, help: @report_item.help, name: @report_item.name, report_category_id: @report_item.report_category_id }
    end

    assert_redirected_to report_item_path(assigns(:report_item))
  end

  test "should show report_item" do
    get :show, id: @report_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @report_item
    assert_response :success
  end

  test "should update report_item" do
    patch :update, id: @report_item, report_item: { description: @report_item.description, help: @report_item.help, name: @report_item.name, report_category_id: @report_item.report_category_id }
    assert_redirected_to report_item_path(assigns(:report_item))
  end

  test "should destroy report_item" do
    assert_difference('ReportItem.count', -1) do
      delete :destroy, id: @report_item
    end

    assert_redirected_to report_items_path
  end
end
