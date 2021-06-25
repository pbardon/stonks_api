require 'rails_helper'

RSpec.describe ExecuteApiQueryJob, type: :job do
  let(:api_connector) do
    instance_double(Apis::FinancialModelingPrepApi)
  end

  describe '#perform' do
    it 'can queue the job to query the exernal api for results' do
      s = create(:search)
      mock_fmp_api(s.ticker)
      ActiveJob::Base.queue_adapter = :test
      expect do
        ExecuteApiQueryJob.perform_later(s.id)
      end.to enqueue_job
    end
  end
end
