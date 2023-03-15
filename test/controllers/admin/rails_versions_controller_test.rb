require "test_helper"

class Admin::RailsVersionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_rails_versions_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_rails_versions_show_url
    assert_response :success
  end
end
