class ArticlesController < ApplicationController
  require 'octokit'
  skip_before_action :authenticate_user!
  before_action :set_article, only: %i[ show ]

  def index
    @articles = Article.all.order("created_at DESC")
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

    _article_index = nil
    _articles_list = Article.get_articles_list
    _articles_list.flatten.each_with_index{|e,i| _article_index = i if e == @article.id}
    if _article_index == 0
      @previous_article = nil
      @next_article = Article.find_by_id(_articles_list.flatten[1])
    elsif _article_index == _articles_list.flatten.count - 1
      @previous_article = Article.find_by_id(_articles_list.flatten[_article_index - 1])
      @next_article = nil
    else
      @previous_article = Article.find_by_id(_articles_list.flatten[_article_index - 1])
      @next_article = Article.find_by_id(_articles_list.flatten[_article_index + 1])
    end
  end

  def get_started
    _articles_list = Article.get_articles_list
    @next_article = _articles_list.flatten.count > 0 ? Article.find_by_id(_articles_list.flatten[0]) : nil
    @categories = Category.order(:position).joins(:articles).uniq
  end

  def what_next
    _articles_list = Article.get_articles_list
    @previous_article = _articles_list.flatten.count > 0 ? Article.find_by_id(_articles_list.flatten[-1]) : nil
  end

  private 

  def set_article
    @article = Article.find_by_id(params[:id])
  end
end
