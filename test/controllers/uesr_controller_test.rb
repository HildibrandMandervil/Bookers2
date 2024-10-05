require "test_helper"

class UesrControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get uesr_show_url
    assert_response :success
  end

  test "should get edit" do
    get uesr_edit_url
    assert_response :success
  end
end
