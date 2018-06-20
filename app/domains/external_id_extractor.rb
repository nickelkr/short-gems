class ExternalIDExtractor
  attr_reader :uri

  def initialize(link)
    @uri = URI.parse(link)
  end

  def perform
    case
    when (yt = Youtube::Extractor.new(uri)).valid_source?
      yt.extract
    else
      raise StandardError.new('No YouTube film found at link')
    end
  end
end
