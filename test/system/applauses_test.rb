require 'application_system_test_case'

class ApplausesTest < ApplicationSystemTestCase
  KYLE_PASS = '12345678'
  test 'adding a applause' do
    user = users(:kyle)

    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: KYLE_PASS
    click_on 'Log in'

    assert_difference('Applause.count') do
      find(:xpath, "//button[@data-film-id='#{films(:one).id}' and @data-category='story']").click
    end

    applause = films(:one).applauses.last
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
    end

    assert_difference('Applause.count', -1) do
      find(:xpath, "//button[@data-film-id='#{films(:one).id}' and @data-category='story']").click
    end
  end

  test 'total count' do
  end

  test 'require user to be logged in' do
    visit films_path

    find(:xpath, "//button[@data-film-id='#{films(:one).id}' and @data-category='sound']").click

    assert_redirected_to new_user_session_path
  end
end
