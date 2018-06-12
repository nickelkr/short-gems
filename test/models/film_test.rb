require 'test_helper'

class FilmTest < ActiveSupport::TestCase
  test 'ensure no duplicates' do
    user = users(:kyle)

    assert_no_difference('Film.count') do
      user.films.create(title: 'New name', runtime: 14, external_id: films(:one).external_id)
    end
  end

  test 'strip domain information' do
    user = users(:kyle)
    link = 'https://youtu.be/HkqIVdMt_bs2'

    user.films.create(title: 'Hotel', runtime: 10, external_id: link)

    assert_equal('HkqIVdMt_bs2', Film.last.external_id)
  end
end
