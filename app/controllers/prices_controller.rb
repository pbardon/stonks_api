# frozen_string_literal: true

# Prices Controller used to provide persisted price data
class PricesController < ApplicationController
  before_action :fetch_company
  before_action :set_price, only: %i[show update destroy]

  # GET /prices
  # GET /prices.json
  # GET /company/{:company_id}
  def index
    if params[:company_id]
      company = Company.find(params[:company_id])
      unless company
        render json: "Unable to find company with id: #{prices}", 
               status: :bad_request
        return
      end
      @prices = company.prices
      process_between_dates_filter(company, params)
      process_sort_by(params)
    else
      @prices = Price.all
    end
  end

  private

  def fetch_company
    @company = Company.find(params[:company_id])
  end

  # Only allow a list of trusted parameters through.
  def price_params
    params.require(:price).permit(:ticker, :open, :close, :high, :low, :volume, :date, :timestamp, :querytype)
  end

  def process_between_dates_filter(company, params)
    return unless params[:start_date] && params[:end_date]

    @prices = company.prices.between_dates(
      Date.parse(params[:start_date]),
      Date.parse(params[:end_date])
    )

    @prices
  end

  def process_sort_by(params)
    return unless params[:sort_by]

    @prices = @prices.sort_by(&params[:sort_by].to_sym)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_price
    @price = Price.find(params[:id])
  end
end
