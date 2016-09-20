class ReviewsController < ApplicationController
  def show
  end

  def index
  end

  def new
  end

  def create
    @review = Product.find(params[:product_id]).reviews.new(review_params)
    @review.user = current_user
    @review.save
    redirect_to product_path(@review.product)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def review_params
    params.require(:review).permit(:stars, :content)
  end
end
