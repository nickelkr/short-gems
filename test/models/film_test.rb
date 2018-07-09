require 'test_helper'

class FilmTest < ActiveSupport::TestCase
  test 'ensure no duplicates' do
    user = users(:kyle)

    assert_no_difference('Film.count') do
      user.films.create(title: 'New name', runtime: 14, external_id: films(:one).external_id)
    end
  end

  test 'no runtimes under 0 minutes' do
    user = users(:kyle)

    assert_no_difference('Film.count') do
      user.films.create(title: 'New name', runtime: -1, external_id: "#{films(:one).external_id}2")
    end
  end

  test 'no runtimes over 50 minutes' do
    user = users(:kyle)

    assert_no_difference('Film.count') do
      user.films.create(title: 'New name', runtime: 60, external_id: "#{films(:one).external_id}2")
    end
  end

  test 'only numbers allowed in runtime' do
    user = users(:kyle)

    assert_no_difference('Film.count') do
      user.films.create(title: 'New name', runtime: 'yellow', external_id: "#{films(:one).external_id}2")
    end
  end
end
