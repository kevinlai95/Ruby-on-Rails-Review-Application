class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  # GET /restaurants
  # GET /restaurants.json
  def index
    
    if params[:category_type].blank?
      @restaurants = Restaurant.paginate(page: params[:page])
    else
      @category_id = Category.find_by(category_type: params[:category_type]).id
      @restaurants = Restaurant.where(:category_id => @category_id)
    end

  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    @reviews = @restaurant.reviews.paginate(page: params[:page])
    if @reviews.blank?
      @average_reviews = 0
    else 
      @average_review = @restaurant.reviews.average(:stars).round(2)
    end
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
    @category = Category.all.map{ |c| [c.category_type, c.id] }
  end

  # GET /restaurants/1/edit
  def edit
    @category = Category.all.map{ |c| [c.category_type, c.id] }
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.category_id = params[:category_id]

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    @restaurant.category_id = params[:category_id]
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name,:website,:city,:street,:zipcode,:state,:phone,:category_id,:avatar)
    end
end
