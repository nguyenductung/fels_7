class CategoriesController < ApplicationController
  before_action :signed_in_user, only: [:index]

  def index
    @categories = Category.order(:name)
  end
end
