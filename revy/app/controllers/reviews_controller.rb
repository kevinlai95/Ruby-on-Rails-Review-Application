class ReviewsController < ApplicationController

	before_action :get_restaurant
	before_action :get_review, only: [:edit, :update, :destroy]

	def new
		@review = Review.new
	end

	def create
		@review = Review.new(review_params)
		@review.restaurant_id = @restaurant.id
		@review.user_id = session[:user_id] 

		if @review.save
			redirect_to restaurant_path(@restaurant)
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @review.update(review_params)
			redirect_to restaurant_path(@restaurant)
		else
			render 'edit'
		end
	end

	private

		def get_restaurant
			@restaurant = Restaurant.find(params[:restaurant_id])
		end

		def get_review
			@review = Review.find(params[:id])
		end

		def review_params
			params.require(:review).permit(:stars, :content)
		end

end
