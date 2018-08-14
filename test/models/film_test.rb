require 'test_helper'

class FilmTest < ActiveSupport::TestCase
  test 'allow duplicates from different sources' do
    user = users(:kyle)

    assert_difference('Film.count') do
      user.films.create(title: 'Another title', runtime: 10, external_id: films(:one).external_id, source: :vimeo)
    end
  end

  test 'ensure no duplicates' do
    user = users(:kyle)

    assert_no_difference('Film.count') do
      user.films.create(title: 'New name', runtime: 14, external_id: films(:one).external_id, source: :youtube)
    end
  end

  test 'no runtimes under 0 minutes' do
    user = users(:kyle)

    assert_no_difference('Film.count') do
      user.films.create(title: 'New name', runtime: -1, external_id: "#{films(:one).external_id}2", source: :youtube)
    end
  end

  test 'no runtimes over 50 minutes' do
    user = users(:kyle)

    assert_no_difference('Film.count') do
      user.films.create(title: 'New name', runtime: 60, external_id: "#{films(:one).external_id}2", source: :youtube)
    end
  end

  test 'only numbers allowed in runtime' do
    user = users(:kyle)

    assert_no_difference('Film.count') do
      user.films.create(title: 'New name', runtime: 'yellow', external_id: "#{films(:one).external_id}2", source: :youtube)
    end
  end
end
