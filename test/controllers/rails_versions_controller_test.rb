require "test_helper"

class RailsVersionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rails_version = rails_versions(:one)
  end

  test "should get index" do
    get rails_versions_url
    assert_response :success
  end

  test "should get new" do
    get new_rails_version_url
    assert_response :success
  end

  test "should create rails_version" do
    assert_difference("RailsVersion.count") do
      post rails_versions_url, params: { rails_version: { is_active: @rails_version.is_active, is_default: @rails_version.is_default, name: @rails_version.name, slug: @rails_version.slug } }
    end

    assert_redirected_to rails_version_url(RailsVersion.last)
  end

  test "should show rails_version" do
    get rails_version_url(@rails_version)
    assert_response :success
  end

  test "should get edit" do
    get edit_rails_version_url(@rails_version)
    assert_response :success
  end

  test "should update rails_version" do
    patch rails_version_url(@rails_version), params: { rails_version: { is_active: @rails_version.is_active, is_default: @rails_version.is_default, name: @rails_version.name, slug: @rails_version.slug } }
    assert_redirected_to rails_version_url(@rails_version)
  end

  test "should destroy rails_version" do
    assert_difference("RailsVersion.count", -1) do
      delete rails_version_url(@rails_version)
    end

    assert_redirected_to rails_versions_url
  end
end
