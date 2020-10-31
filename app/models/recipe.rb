class Recipe
  class << self
    def all
      client.entries(content_type: 'recipe')
    end

    private

    def client
      @client ||= Contentful::Client.new(
        space: ENV['CONTENTFUL_SPACE_ID'],
        access_token: ENV['CONTENTFUL_ACCESS_TOKEN']
      )
    end
  end
end
