class Article < ApplicationRecord
  belongs_to :category
  belongs_to :rails_version
end
