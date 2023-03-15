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
    client = Octokit::Client.new(:access_token => "#{Figaro.env.GITHUB_ACCESS_TOKEN}")
    @response = client.contents("#{Figaro.env.GITHUB_REPO}", path: @article.github_link, query: {},  :accept => 'application/vnd.github.html')
    @suggested_articles = Article.where(category_id: @article.category.get_parent_categories(@article.category.try(:id), [])).where.not(id: params[:id]).limit(10)
  end

  def get_started
  end

  def what_next
  end

  private 

  def set_article
    @article = Article.find_by_id(params[:id])
  end
end
