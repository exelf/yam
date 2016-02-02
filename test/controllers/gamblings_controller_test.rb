require 'test_helper'

class GamblingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get gamblings_index_url
    assert_response :success
  end

  test "should get show" do
    get gamblings_show_url
    assert_response :success
  end

end
