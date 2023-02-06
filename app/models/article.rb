class Article < ApplicationRecord
  belongs_to :category
  belongs_to :rails_version

  validates_presence_of :key, :github_link, :author_name, :title
  validates_uniqueness_of :key

  scope :by_category,             -> (category) { where( category_id: category )}
  scope :by_rails_version,             -> (rails_version) { where( rails_version_id: rails_version )}

  before_create :set_attributes

  private

  def set_attributes
    self.piblished_at = Time.now
  end

  def self.search_by_text(query)
    where(<<-SQL, "%#{query.downcase}%" )
      articles.title ilike ?
    SQL
  end

end
