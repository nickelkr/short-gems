module Youtube
  class Extractor
    attr_accessor :scheme,
                  :domain,
                  :path,
                  :query_params,
                  :external_id

    ALLOWED_DOMAINS = [
      'youtu.be',
      'www.youtube.com',
      'youtube.com'
    ].freeze

    ALLOWED_SCHEMES = [
      'http',
      'https'
    ].freeze

    ID_REGEX = /^[a-zA-Z0-9\-_]+$/

    def initialize(uri)
      @scheme = uri.scheme
      @domain = uri.host
      @path = uri.path
      @query_params = CGI.parse(uri.query) if uri.query.present?
    end

    def valid_source?
      ALLOWED_SCHEMES.include?(scheme) &&
        ALLOWED_DOMAINS.include?(domain)
    end

    def extract
      extract_id
      valid_id?
      external_id
    end

    private
      def valid_id?
        raise StandardError.new('Invalid YouTube ID') unless ID_REGEX =~ external_id
      end

      def extract_id
        if domain == 'youtu.be'
          @external_id = path.sub(/^\//, '')
        elsif domain == 'www.youtube.com' || domain == 'youtube.com'
          @external_id = query_params['v'].first
        end
      end
  end
end
