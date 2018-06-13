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
    end

  test "should get index" do

  end

  test "should destroy film" do
    @user = users(:kyle)
    sign_in(@user)

    film = films(:one)
    assert_difference('Film.count', -1) do
      delete film_url(film)
    end

    assert_redirected_to(films_path)
    assert_equal("Film removed", flash[:success])
  end

  test "should fail to destroy due to permissions" do
    @user = users(:kyle)
    sign_in(@user)

    film = films(:two)
    assert_no_difference('Film.count') do
      delete film_url(film)
    end

    assert_redirected_to(films_path)
    assert_equal('You are not allowed to remove this film', flash[:error])
  end

  test 'should fail due to film not found' do
    @user = users(:kyle)
    sign_in(@user)

    assert_no_difference('Film.count') do
      delete film_url(999999999999)
    end

    assert_redirected_to(films_path)
    assert_equal('Film not found', flash[:error])
  end

  test "should get new" do
    @user = users(:kyle)
    sign_in(@user)

    film = films(:two)
    assert_no_difference('Film.count') do
      delete film_url(film)
    end
  end
end
