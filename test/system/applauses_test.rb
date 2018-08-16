require 'application_system_test_case'

class ApplausesTest < ApplicationSystemTestCase
  def button_with_attr_values(attr_mapping)
    xpath = attr_mapping.reduce('') do |xpath_memo, (attr, value)|
      if xpath_memo.empty?
        xpath_memo += '//button['
      else
        xpath_memo += ' and '
      end

      xpath_memo + " @data-#{attr.to_s.tr('_', '-')}='#{value}'"
    end
    xpath += ']'

    find(:xpath, xpath)
  end

  KYLE_PASS = '12345678'
  test 'adding a applause' do
    visit new_user_session_path
    user = sign_in_from_view(:kyle, KYLE_PASS)
    film = films(:one)

    assert_difference('Applause.count') do
      button_with_attr_values(film_id: film.id, category: 'story').click
      sleep 0.5
    end

    applause = film.applauses.last
    assert_equal(user, applause.user)
    assert_equal('story', applause.category)
  end

  test 'existing applause renders' do
    visit new_user_session_path
    sign_in_from_view(:kyle, KYLE_PASS)

    assert (button_with_attr_values(film_id: films(:one).id,
                                    category: 'directing',
                                    method: 'DELETE',
                                    category_id: applauses(:directing).id))
  end

  test 'removing a applause' do
    visit new_user_session_path
    sign_in_from_view(:kyle, KYLE_PASS)

    assert_difference('Applause.count') do
      button_with_attr_values(film_id: films(:one).id, category: 'story').click
      sleep 0.5
    end

    assert_difference('Applause.count', -1) do
      button_with_attr_values(film_id: films(:one).id, category: 'story').click
      sleep 0.5
    end
  end

  test 'total count' do
    visit new_user_session_path
    sign_in_from_view(:kyle, KYLE_PASS)

    film = films(:one)

    button_with_attr_values(film_id: film.id, category: 'acting').click
    sleep 0.5

    total = find(:xpath, "//strong[@data-film-id='#{film.id}' and @data-type='total']")

    assert_equal("+ #{film.applauses.count}", total.text)
  end

  test 'require user to be logged in' do
    visit films_path

    first(:button, '+').click

    assert_current_path('/users/sign_in')
  end

  JAKE_PASS = '1234567890'
  test 'show page voting' do
    visit new_user_session_path
    sign_in_from_view(:jake, JAKE_PASS)

    film = films(:one)

    visit films_path(film.id)

    assert_difference('Applause.count') do
      button_with_attr_values(film_id: film.id, category: 'story').click
      sleep 0.5
    end

    applause = film.applauses.last
    assert_equal(user, applause.user)
    assert_equal('story', applause.category)
  end
end
