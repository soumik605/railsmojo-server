class ArticlesController < ApplicationController
  require 'octokit'
  skip_before_action :authenticate_user!
  before_action :set_article, only: %i[ show ]

  def index
    @articles = Article.all
    @articles = @articles.by_category(params[:category_id]) if params[:category_id].present?
    @articles = @articles.by_rails_version(params[:rails_version_id]) if params[:rails_version_id].present?
    @articles = @articles.search_by_text(params[:search]) if params[:search].present?

    @categories = Category.active
    @rails_versions = RailsVersion.active
  end

  def show
    client = Octokit::Client.new(:access_token => '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')
    @response = client.contents('soumik605/soumik605', path: @article.github_link, query: {},  :accept => 'application/vnd.github.html')
    @suggested_articles = Article.by_category(@article.category_id).limit(10)
  end

  private 

  def set_article
    @article = Article.find_by_id(params[:id])
  end
end
