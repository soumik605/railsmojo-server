class RailsVersion < ApplicationRecord
  has_many :articles
  has_many :categories

  validates_presence_of :name, :slug
  validates_uniqueness_of :name, :slug

  scope :active, ->               { where( is_active: true )}

end
