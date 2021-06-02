class PricesController < ApplicationController
  before_action :get_company
  before_action :set_price, only: %i[ show update destroy ]

  # GET /prices
  # GET /prices.json
  def index
    @prices = Price.all
  end

  # GET /prices/1
  # GET /prices/1.json
  def show
  end

  # POST /prices
  # POST /prices.json
  def create
    @price = @company.prices.new(price_params)

    if @price.save
      render :show, status: :created, location: @price
    else
      render json: @price.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /prices/1
  # PATCH/PUT /prices/1.json
  def update
    if @price.update(price_params)
      render :show, status: :ok, location: @price
    else
      render json: @price.errors, status: :unprocessable_entity
    end
  end

  # DELETE /prices/1
  # DELETE /prices/1.json
  def destroy
    @price.destroy
  end

  def price_url(price)
    company_price_url(@company.id, price)
  end

  private
    def get_company
      @company = Company.find(params[:company_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_price
      @price = Price.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def price_params
      params.require(:price).permit(:ticker, :open, :close, :high, :low, :volume, :timestamp, :querytype)
    end
end
