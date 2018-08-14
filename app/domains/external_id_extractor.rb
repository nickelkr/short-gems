class ExternalIDExtractor
  attr_reader :uri

  def initialize(link)
    @uri = URI.parse(link)
  end

  def perform
    case
    when (yt = Youtube::Extractor.new(uri)).valid_source?
      { external_id: yt.extract, source: :youtube }
    else
      raise StandardError.new('Only YouTube videos are currently supported.')
    end
  end
end
