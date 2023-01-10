require "application_system_test_case"

class ArticlesTest < ApplicationSystemTestCase
  setup do
    @article = articles(:one)
  end

  test "visiting the index" do
    visit articles_url
    assert_selector "h1", text: "Articles"
  end

  test "should create article" do
    visit articles_url
    click_on "New article"

    fill_in "Author name", with: @article.author_name
    fill_in "Category", with: @article.category_id
    fill_in "Github link", with: @article.github_link
    fill_in "Key", with: @article.key
    fill_in "Piblished at", with: @article.piblished_at
    fill_in "Rails version", with: @article.rails_version_id
    click_on "Create Article"

    assert_text "Article was successfully created"
    click_on "Back"
  end

  test "should update Article" do
    visit article_url(@article)
    click_on "Edit this article", match: :first

    fill_in "Author name", with: @article.author_name
    fill_in "Category", with: @article.category_id
    fill_in "Github link", with: @article.github_link
    fill_in "Key", with: @article.key
    fill_in "Piblished at", with: @article.piblished_at
    fill_in "Rails version", with: @article.rails_version_id
    click_on "Update Article"

    assert_text "Article was successfully updated"
    click_on "Back"
  end

  test "should destroy Article" do
    visit article_url(@article)
    click_on "Destroy this article", match: :first

    assert_text "Article was successfully destroyed"
  end
end
