class ApplicationController < ActionController::API
    before_action :set_default_response_format

    # enable JBuilder in the rendering process
    include ActionController::ImplicitRender

    protected
    
    def set_default_response_format
        request.format = :json
    end
end