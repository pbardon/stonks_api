# frozen_string_literal: true

# Module used as a namespace to contain any APIs we need to interface with
module Apis
  # Common methods and definitions for all APIs
  class Api
    include HTTParty

    def initialize(url)
      @url = url
    end

    def query
      self.class.get(@url)
    end
  end
end
