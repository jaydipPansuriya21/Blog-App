require 'test_helper'

class RndrControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rndr_index_url
    assert_response :success
  end

  test "should get show" do
    get rndr_show_url
    assert_response :success
  end

end
