require 'application_system_test_case'
require 'test_helper'

class FilmsTest < ApplicationSystemTestCase
  KYLE_PASS = '12345678'
  test 'creating a film' do
    visit new_film_path
    sign_in_from_view(:kyle, KYLE_PASS)

    fill_in 'film_title', with: 'Hotel Chevalier'
    fill_in 'film_runtime', with: 12
    fill_in 'film_external_id', with: 'https://youtu.be/HkqIVdMt_bs2'

    assert_difference('Film.count') do
      click_on 'Submit'
    end
  end

  test 'deleting a film' do
    visit new_user_session_path
    sign_in_from_view(:kyle, KYLE_PASS) 

    visit films_path

    assert_difference('Film.count', -1) do
      click_link("remove-#{films(:one).id}")
    end
  end

  ADMIN_PASS = '1234567890'
  test 'admin deleting a film' do
    visit new_user_session_path
    sign_in_from_view(:admin, ADMIN_PASS)

    visit films_path

    assert_difference('Film.count', -1) do
      click_link("remove-#{films(:one).id}")
    end
  end

# These tests take way to long to run so for now we cannot use them
#  JAKE_PASS = '1234567890'
#  test 'pagination' do
#    @user = users(:jake)
#
#    visit new_user_session_path
#
#    fill_in 'user_email', with: @user.email
#    fill_in 'user_password', with: JAKE_PASS
#    click_on 'Log in'
#
#    visit films_path
#
#    assert_difference('Pagy::VARS[:page]') do
#      byebug
#      click_on '2'
#    end  
#  end
end
