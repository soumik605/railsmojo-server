class Category < ApplicationRecord
  belongs_to :rails_version
  belongs_to :parent_category, optional: true, class_name: 'Category', inverse_of: :categories
  has_many :articles
  has_many :categories, foreign_key: :parent_category_id, dependent: :destroy, inverse_of: :parent_category

  validates_presence_of :name, :slug, :position, :description
  validates_uniqueness_of :name, :slug

  scope :active, ->               { where( is_active: true )}


  def get_sub_categories(categories, articles)
    str = ""
    articles.each { |a|
      str += "<li class='py-1 px-2 text-xs font-semibold text-gray-900 transition duration-75 rounded-lg group dark:text-white'><a href='/articles/#{a.try(:id)}'>#{a.try(:title)}</a></li>"
    } 

    categories.each { |c|
      str +=  "<li><button type=button class='flex items-center w-full p-1 text-xs font-normal text-gray-900 transition duration-75 rounded-lg group dark:text-white' aria-controls='dropdown-category-#{c.try(:id)}' data-collapse-toggle='dropdown-category-#{c.try(:id)}'>
      <svg sidebar-toggle-item class='w-5 h-5' fill=currentColor viewBox='0 0 20 20' xmlns='http://www.w3.org/2000/svg'><path fill-rule=evenodd d='M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z' clip-rule=evenodd></path></svg><span class='flex-1 ml-3 text-left whitespace-nowrap' sidebar-toggle-item>#{c.try(:name)}</span></button>"
      str += "<ul class='hidden ml-4 border-l border-gray-200 dark:border-gray-700' id='dropdown-category-#{c.try(:id)}' >"
      str += c.get_sub_categories(c.categories.order("position"), c.articles )
      str += "</ul>"
      str += "</li>"
    }
    return str
  end

  def get_articles articles
    arr = articles
    self.articles.each {|a| arr << a.id}
    self.categories.order("position").each { |c| c.get_articles(arr) }
    arr.flatten.uniq
  end

  def get_parent_categories(category_id, arrs)
    _arr = arrs
    _cat = Category.find_by_id(category_id)
    _arr << category_id if  _cat.present?

    _cat.get_parent_categories(_cat.parent_category_id, _arr) if  _cat.try(:parent_category_id).present?
    _arr
  end

  def change_category_position position 
    notice = ""
    if self.position.to_i > position.to_i # move top
      Category.where("position BETWEEN ? AND ?", position.to_i, self.position.to_i - 1).each { |cat| cat.update(position: cat.position + 1) }
    elsif self.position.to_i < position.to_i # move bottom
      Category.where("position BETWEEN ? AND ?", self.position.to_i + 1, position.to_i).each { |cat| cat.update(position: cat.position - 1) }
    end
    if self.update(position: position)
      notice = "success"
    end
  end
end
