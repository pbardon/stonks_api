class API
    include HTTParty

    def initialize(url)
        @url = url
    end

    def find()
        response = self.class.get(@url)
    end
end