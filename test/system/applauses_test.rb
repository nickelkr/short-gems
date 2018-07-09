require 'application_system_test_case'

class ApplausesTest < ApplicationSystemTestCase
  def button_by_film_category(film_id, category)
    find(:xpath,"//button[@data-film-id='#{film_id}' and @data-category='#{category}']")
  end

  KYLE_PASS = '12345678'
  test 'adding a applause' do
    visit new_user_session_path
    user = sign_in_from_view(:kyle, KYLE_PASS)
    film = films(:one)

    assert_difference('Applause.count') do
      button_by_film_category(film.id, 'story').click
      sleep 0.5
    end

    applause = film.applauses.last
    assert_equal(user, applause.user)
    assert_equal('story', applause.category)
  end

  test 'existing applause renders' do
    visit new_user_session_path
    sign_in_from_view(:kyle, KYLE_PASS)

    assert find(:xpath, "//button[@data-film-id='#{films(:one).id}'" +
                        "and @data-category='directing'" + 
                        "and @data-method='DELETE'" + 
                        "and @data-category-id='#{applauses(:directing).id}']")
  end

  test 'removing a applause' do
    visit new_user_session_path
    sign_in_from_view(:kyle, KYLE_PASS)

    assert_difference('Applause.count') do
      button_by_film_category(films(:one).id, 'story').click
      sleep 0.5
    end

    assert_difference('Applause.count', -1) do
      button_by_film_category(films(:one).id, 'story').click
      sleep 0.5
    end
  end

  test 'total count' do
    visit new_user_session_path
    sign_in_from_view(:kyle, KYLE_PASS)

    film = films(:one)

    button_by_film_category(film.id, 'acting').click
    sleep 0.5

    total = find(:xpath, "//strong[@data-film-id='#{film.id}' and @data-type='total']")

    assert_equal("+ #{film.applauses.count}", total.text)
  end

  test 'require user to be logged in' do
    visit films_path

    first(:button, '+').click

    assert_current_path('/users/sign_in')
  end
end
