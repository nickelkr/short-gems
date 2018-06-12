require 'test_helper'

class FilmTest < ActiveSupport::TestCase
  test 'ensure no duplicates' do
    user = users(:kyle)

    assert_no_difference('Film.count') do
      user.films.create(title: 'New name', runtime: 14, external_id: films(:one).external_id)
    end
  end
end
