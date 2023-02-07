class Category < ApplicationRecord
  belongs_to :rails_version
  has_many :articles

  validates_presence_of :name, :slug, :position, :description
  validates_uniqueness_of :name, :slug, :position

  scope :active, ->               { where( is_active: true )}
end
