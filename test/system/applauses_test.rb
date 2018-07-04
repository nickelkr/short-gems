require 'application_system_test_case'

class ApplausesTest < ApplicationSystemTestCase
  KYLE_PASS = '12345678'
  test 'adding a applause' do
    user = users(:kyle)

    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: KYLE_PASS
    click_on 'Log in'

    film = films(:one)
    assert_difference('Applause.count') do
      find(:xpath, "//button[@data-film-id='#{film.id}' and @data-category='story']").click
      sleep 0.5
    end

    applause = film.applauses.last
    assert_equal(user, applause.user)
    assert_equal('story', applause.category)
  end

  test 'existing applause renders' do
    user = users(:kyle)

    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: KYLE_PASS
    click_on 'Log in'

    assert find(:xpath, "//button[@data-film-id='#{films(:one).id}'" +
                        "and @data-category='directing'" + 
                        "and @data-method='DELETE'" + 
                        "and @data-category-id='#{applauses(:directing).id}']")
  end

  test 'removing a applause' do
    user = users(:kyle)

    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: KYLE_PASS
    click_on 'Log in'

    assert_difference('Applause.count') do
      find(:xpath, "//button[@data-film-id='#{films(:one).id}' and @data-category='story']").click
      sleep 0.5
    end

    assert_difference('Applause.count', -1) do
      find(:xpath, "//button[@data-film-id='#{films(:one).id}' and @data-category='story']").click
      sleep 0.5
    end
  end

  test 'total count' do
    user = users(:kyle)

    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: KYLE_PASS
    click_on 'Log in'

    film = films(:one)

    find(:xpath, "//button[@data-film-id='#{film.id}' and @data-category='acting']").click
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
