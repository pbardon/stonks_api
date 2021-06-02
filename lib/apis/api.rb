module Apis
    class Api
        include HTTParty

        def initialize(url)
            @url = url
        end

        def query()
            response = self.class.get(@url)
        end
    end
end