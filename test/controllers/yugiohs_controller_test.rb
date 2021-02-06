require "test_helper"

class YugiohsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get yugiohs_index_url
    assert_response :success
  end
end
