require 'application_system_test_case'

class FilmsTest < ApplicationSystemTestCase
  test 'creating a film' do
    visit new_film_path

    fill_in 'film_title', with: 'Hotel Chevalier'
    fill_in 'film_runtime', with: 12
    fill_in 'film_external_id', with: 'https://youtu.be/HkqIVdMt_bs'

    assert_difference('Film.count') do
      click_on 'Submit'
    end
  end
end
