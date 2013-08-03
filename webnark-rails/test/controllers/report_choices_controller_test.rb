require 'test_helper'

class ReportChoicesControllerTest < ActionController::TestCase
  setup do
    @report_choice = report_choices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:report_choices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create report_choice" do
    assert_difference('ReportChoice.count') do
      post :create, report_choice: { bonus: @report_choice.bonus, help: @report_choice.help, name: @report_choice.name, points: @report_choice.points, report_item_id: @report_choice.report_item_id }
    end

    assert_redirected_to report_choice_path(assigns(:report_choice))
  end

  test "should show report_choice" do
    get :show, id: @report_choice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @report_choice
    assert_response :success
  end

  test "should update report_choice" do
    patch :update, id: @report_choice, report_choice: { bonus: @report_choice.bonus, help: @report_choice.help, name: @report_choice.name, points: @report_choice.points, report_item_id: @report_choice.report_item_id }
    assert_redirected_to report_choice_path(assigns(:report_choice))
  end

  test "should destroy report_choice" do
    assert_difference('ReportChoice.count', -1) do
      delete :destroy, id: @report_choice
    end

    assert_redirected_to report_choices_path
  end
end
