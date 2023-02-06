json.extract! article, :id, :category_id, :rails_version_id, :key, :github_link, :author_name, :piblished_at, :created_at, :updated_at
json.url article_url(article, format: :json)
