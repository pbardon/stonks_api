require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/prices", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Price. As you add validations to Price, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryBot.build(:price).attributes.symbolize_keys
  }

  let(:invalid_attributes) {
    { ticker: "AAPL", querytype: '5m'}
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # PricesController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  before(:each) do
    puts "Company.length #{Company.all.length}"
    @company = create(:company)
  end

  after(:each) do
    if @company
      @company.destroy!
    end
  end

  describe "GET  /company/**TICKER**/prices" do
    it "renders a successful response" do
      @company.prices.create!(valid_attributes)
      get company_prices_url(@company.ticker), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /company/**TICKER**/prices/**ID**" do
    it "renders a successful response" do
      price = @company.prices.create!(valid_attributes)
      get company_prices_url(@company.ticker, price), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /company/**TICKER**/create" do
    context "with valid parameters" do
      it "creates a new Price" do
        expect {
          post company_prices_url(@company.ticker),
               params: { price: valid_attributes }, headers: valid_headers, as: :json
        }.to change(@company.prices, :count).by(1)
      end

      it "renders a JSON response with the new price" do
        post company_prices_url(@company.ticker),
             params: { price: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Price" do
        expect {
          post company_prices_url(@company.ticker),
               params: { price: invalid_attributes }, as: :json
        }.to change(@company.prices, :count).by(0)
      end

      it "renders a JSON response with errors for the new price" do
        post company_prices_url(@company.ticker),
             params: { price: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /company/**TICKER**/destroy" do
    it "destroys the requested price" do
      price = @company.prices.create! valid_attributes
      expect {
        delete company_price_url(@company.ticker, price.id), headers: valid_headers, as: :json
      }.to change(@company.prices, :count).by(-1)
    end
  end
end
