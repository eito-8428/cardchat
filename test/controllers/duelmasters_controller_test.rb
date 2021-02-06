require "test_helper"

class DuelmastersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get duelmasters_index_url
    assert_response :success
  end
end
