class Article < ApplicationRecord
  belongs_to :category
  belongs_to :rails_version

  validates_presence_of :key, :github_link, :author_name, :title
  validates_uniqueness_of :key

  scope :by_category,             -> (category) { where( category_id: category )}
  scope :by_rails_version,             -> (rails_version) { where( rails_version_id: rails_version )}

  before_validation :set_attributes, :on => :create

  private

  def set_attributes
    self.piblished_at = Time.now
  end

  def self.search_by_text(query)
    where(<<-SQL, "%#{query.downcase}%" )
      articles.title ilike ?
    SQL
  end

  def self.get_articles_list
    list = []
    Category.where(parent_category_id: nil).order("position").each do |c|
      list << c.get_articles(c.articles.pluck(:id))
    end
    list
  end

  def set_attributes
    self.key = Article.all.count == 0 ? "article-key-1" : "article-key-#{Article.last.id + 1}"
  end

end
