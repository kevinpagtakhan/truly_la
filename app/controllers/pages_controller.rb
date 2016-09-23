class PagesController < ApplicationController
  def home
    @best_seller = Product.first(3)
  end

  def about
  end

  def contact
  end
end
