module Youtube
  class Extractor
    attr_accessor :scheme, :domain, :query_params

    ALLOWED_DOMAINS = [
      'youtu.be',
      'www.youtube.com',
      'youtube.com'
    ].freeze

    ALLOWED_SCHEMES = [
      'http',
      'https'
    ].freeze

    def initialize(uri)
      @scheme = uri.scheme
      @domain = uri.host
      @query_params = CGI.parse(uri.query) if uri.query.present?
    end

    def valid_source?
      ALLOWED_SCHEMES.include?(scheme) &&
        ALLOWED_DOMAINS.include?(domain)
    end
  end
end
