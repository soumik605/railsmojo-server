class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @categories = Category.active
  end
end
