require 'test_helper'

class RollsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get rolls_show_url
    assert_response :success
  end

  test "should get edit" do
    get rolls_edit_url
    assert_response :success
  end

end
