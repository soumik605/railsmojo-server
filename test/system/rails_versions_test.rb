require "application_system_test_case"

class RailsVersionsTest < ApplicationSystemTestCase
  setup do
    @rails_version = rails_versions(:one)
  end

  test "visiting the index" do
    visit rails_versions_url
    assert_selector "h1", text: "Rails versions"
  end

  test "should create rails version" do
    visit rails_versions_url
    click_on "New rails version"

    check "Is active" if @rails_version.is_active
    check "Is default" if @rails_version.is_default
    fill_in "Name", with: @rails_version.name
    fill_in "Slug", with: @rails_version.slug
    click_on "Create Rails version"

    assert_text "Rails version was successfully created"
    click_on "Back"
  end

  test "should update Rails version" do
    visit rails_version_url(@rails_version)
    click_on "Edit this rails version", match: :first

    check "Is active" if @rails_version.is_active
    check "Is default" if @rails_version.is_default
    fill_in "Name", with: @rails_version.name
    fill_in "Slug", with: @rails_version.slug
    click_on "Update Rails version"

    assert_text "Rails version was successfully updated"
    click_on "Back"
  end

  test "should destroy Rails version" do
    visit rails_version_url(@rails_version)
    click_on "Destroy this rails version", match: :first

    assert_text "Rails version was successfully destroyed"
  end
end
