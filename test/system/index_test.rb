require 'application_system_test_case'

class IndexTest < ApplicationSystemTestCase
  test 'film listing' do
    visit films_path

    first_id = films(:one).external_id.split('/').last
    second_id = films(:two).external_id.split('/').last
    first_link = "https://www.youtube.com/embed/#{first_id}"
    second_link = "https://www.youtube.com/embed/#{second_id}"

    assert page.has_xpath?("//iframe[@src='#{first_link}']")
    assert page.has_xpath?("//iframe[@src='#{second_link}']")
  end
end
