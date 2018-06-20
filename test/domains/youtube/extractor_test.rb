require 'test_helper'

module Youtube
  class ExtractorTest < ActiveSupport::TestCase
    test 'shortened link' do
      link = URI.parse('https://youtu.be/yellowfin')

      assert(Youtube::Extractor.new(link).valid_source?)
    end

    test 'with query params' do
      link = URI.parse('https://www.youtube.com/watch?v=QSwvg9Rv2EI')

      assert(Youtube::Extractor.new(link).valid_source?)
    end

    test 'invalid_souce? source' do
      link = URI.parse('https://unsupported.com/a-npmDGK1Dc')
      
      assert_not(Youtube::Extractor.new(link).valid_source?)
    end
  end
end
