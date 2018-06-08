require 'test_helper'

class FilmsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    assert_difference('Film.count') do
      post films_url, 
           params: { film: { title: 'Hotel Chevalier', runtime: 13, external_id: 'yellowfin' } }
    end

    assert_response :success
  end

  test "should get index" do
  end

  test "should get destroy" do
    film = films(:one)
    assert_difference('Film.count', -1) do
      delete film_url(film)
    end

    assert_response :success
  end

  test "should get new" do
  end

end
