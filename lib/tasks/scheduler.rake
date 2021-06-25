desc 'This task is called by the Heroku scheduler add-on'

task reset_api_count: :environment do
  Apis::FinancialModelingPrepApi.reset_count(75)
end
