require 'test_helper'

class ExternalIDExtractorTest < ActiveSupport::TestCase
  test '#extract_id' do
    EX_ID = '12ab34cd'
    GOOD_URL = "https://youtu.be/#{EX_ID}"

    mock = Minitest::Mock.new
    mock.expect(:valid_source?, true)
    mock.expect(:extract, EX_ID)

    Youtube::Extractor.stub(:new, mock) do
      assert_equal(EX_ID, ExternalIDExtractor.new(GOOD_URL).perform)
    end

    assert_mock(mock)
  end

  test '#extract_id w/ unsupported domain' do
    BAD_URL = 'https://vimeo.com/123156'

    mock = Minitest::Mock.new
    mock.expect(:valid_source?, false)

    Youtube::Extractor.stub(:new, mock) do
      assert_raise(StandardError, 'No YouTube film found at link') do
        ExternalIDExtractor.new(BAD_URL).perform
      end
    end

    assert_mock(mock)
  end
end
