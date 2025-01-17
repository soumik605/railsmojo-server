class Admin::ArticlesController < ApplicationController
  require 'octokit'
  layout 'admin'

  before_action :set_article, only: %i[ show edit update destroy ]

  def index
    @articles = Article.all
    @articles = @articles.paginate(:page => params[:page], :per_page => 10)

    @article = Article.new
    @rails_versions = RailsVersion.all
    @rails_versions = @rails_versions.active if @rails_versions.count != 0
    @categories = Category.all
    @categories = @categories.active if @categories.count != 0
  end

  def show
    client = Octokit::Client.new(:access_token => "#{Figaro.env.GITHUB_ACCESS_TOKEN}")
    @response = client.contents("#{Figaro.env.GITHUB_REPO}", path: @article.github_link, query: {},  :accept => 'application/vnd.github.html')
    @suggested_articles = Article.by_category(@article.category_id).where.not(id: params[:id]).limit(10)
  end

  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to admin_articles_url, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to admin_articles_url, notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to admin_articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:category_id, :rails_version_id, :title, :key, :github_link, :author_name, :piblished_at)
    end
end
