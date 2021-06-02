require "rails_helper"

RSpec.describe PricesController, type: :routing do
  describe "routing" do
    before(:all) do
      @company = create(:company)
    end

    after(:all) do
      if @company
        @company.destroy!
      end
    end

    it "routes to #index" do
      expect(get: "companies/#{@company.ticker}/prices").to route_to(controller: "prices", action: "index", company_ticker: @company.ticker)
    end

    it "routes to #show" do
      expect(get: "companies/#{@company.ticker}/prices/1").to route_to(controller: "prices", action: "show", id: "1", company_ticker: @company.ticker)
    end


    it "routes to #create" do
      expect(post: "/companies/#{@company.ticker}/prices").to route_to("prices#create", company_ticker: @company.ticker)
    end

    it "routes to #update via PUT" do
      expect(put: "/companies/#{@company.ticker}/prices/1").to route_to(controller: "prices", action: "update", company_ticker: @company.ticker, id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/companies/#{@company.ticker}/prices/1").to route_to(controller: "prices", action: "update", company_ticker: @company.ticker, id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/companies/#{@company.ticker}/prices/1").to route_to(controller: "prices", action: "destroy", company_ticker: @company.ticker, id: "1")
    end
  end
end
