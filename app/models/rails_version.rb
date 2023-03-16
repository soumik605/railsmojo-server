class RailsVersion < ApplicationRecord
    has_many :articles
    has_many :categories

    validates_presence_of :name, :slug
    validates_uniqueness_of :name, :slug

    scope :active, ->               { where( is_active: true )}

    before_validation :set_attributes, :on => :create

    private

    def set_attributes
        self.slug = RailsVersion.all.count == 0 ? "version-1" : "version-#{RailsVersion.last.id + 1}"
    end

end
