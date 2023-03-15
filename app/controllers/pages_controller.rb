class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @categories = Category.all
    @categories = @categories.active if @categories.count != 0
  end
end
