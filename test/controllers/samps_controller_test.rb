require "test_helper"

class SampsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get samps_index_url
    assert_response :success
  end

  test "should get show" do
    get samps_show_url
    assert_response :success
  end

  test "should get create" do
    get samps_create_url
    assert_response :success
  end
end
