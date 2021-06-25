require 'rails_helper'

RSpec.describe ExecuteApiQueryJob, type: :job do
  let(:api_connector) do
    instance_double(Apis::FinancialModelingPrepApi)
  end

  describe "#perform" do
    it 'can query the exernal api for results' do
      s = create(:search)
      mock_fmp_api(s.ticker)
      ExecuteApiQueryJob.perform_now(s.id)
    end
  end
end
