require 'test_helper'

module Youtube
  class ExtractorTest < ActiveSupport::TestCase
    SHORT_LINK = URI.parse('https://youtu.be/yellowfin')
    WITH_QUERY = URI.parse('https://www.youtube.com/watch?v=QSwvg9Rv2EI')
    BAD_LINK   = URI.parse('https://unsupported.com/a-npmDGK1Dc')
    BAD_ID     = URI.parse('http://youtu.be/.ase')

    test 'shortened link' do
      assert(Youtube::Extractor.new(SHORT_LINK).valid_source?)
    end

    test 'with query params' do
      assert(Youtube::Extractor.new(WITH_QUERY).valid_source?)
    end

    test 'invalid_souce? source' do
      assert_not(Youtube::Extractor.new(BAD_LINK).valid_source?)
    end

    test 'short link extraction' do
      assert_equal('yellowfin', Youtube::Extractor.new(SHORT_LINK).extract)
    end

    test 'link w/ query params extraction' do
      assert_equal('QSwvg9Rv2EI', Youtube::Extractor.new(WITH_QUERY).extract)
    end

    test 'bad external id extraction failure' do
      assert_raises(StandardError, 'Invalid YouTube ID') do
        Youtube::Extractor.new(BAD_ID).extract
      end
    end
  end
end
