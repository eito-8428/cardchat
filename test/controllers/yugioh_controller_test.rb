require "test_helper"

class YugiohControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get yugioh_index_url
    assert_response :success
  end
end
