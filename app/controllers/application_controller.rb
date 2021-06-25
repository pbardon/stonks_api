# frozen_string_literal: true

# Application controller used to define methods and setting applicable to all controllers.
class ApplicationController < ActionController::API
  before_action :ensure_json_request

  # Respond with JSON to every request
  def ensure_json_request
    request.format = :json
  end
end
