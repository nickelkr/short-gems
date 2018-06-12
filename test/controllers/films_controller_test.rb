require 'test_helper'

class FilmsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

    params =
      {
        film: 
        { 
          title: 'Hotel Chevalier', 
          runtime: 13, 
          external_id: 'yellowfin' 
        }
      }

    test "should not create film if not logged in" do
      assert_no_difference('Film.count') do
        post films_url,
          params: params
      end
    end

    test "should get create" do
      @user = users(:kyle)
      sign_in(@user) 

      assert_difference('Film.count') do
        post films_url, 
             params: params
      end

      assert_response :success
    end

  test "should get index" do
  end

  test "should get destroy" do
    @user = users(:kyle)
    sign_in(@user)

    film = films(:one)
    assert_difference('Film.count', -1) do
      delete film_url(film)
    end

    assert_response :success
  end

  test "should get new" do
  end
end
