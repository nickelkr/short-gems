require 'application_system_test_case'

class FilmsTest < ApplicationSystemTestCase
  KYLE_PASS = '12345678'

  test 'creating a film' do
    @user = users(:kyle)

    visit new_film_path

    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: KYLE_PASS
    click_on 'Log in'

    fill_in 'film_title', with: 'Hotel Chevalier'
    fill_in 'film_runtime', with: 12
    fill_in 'film_external_id', with: 'https://youtu.be/HkqIVdMt_bs2'

    assert_difference('Film.count') do
      click_on 'Submit'
    end
  end
end
