require 'test_helper'

class FilmsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

    params =
      {
        film: 
        { 
          title: 'Hotel Chevalier', 
          runtime: 13, 
          external_id: 'https://youtu.be/yellowfin' 
        }
      }

    test 'should not create a film with a unexpected source' do
      sign_in_as(:kyle)

      assert_no_difference('Film.count') do
        post films_url,
          params: {
            film:
            { 
              title: 'Something',
              runtime: 1,
              external_id: 'https://unsupported.com/a-npmDGK1Dc'
            }
        }
      end

      assert_redirected_to(films_path)
      assert_equal('Only YouTube videos are currently supported.', flash[:error])
    end

    test 'should be able to use alternate YouTube link' do
      sign_in_as(:kyle)

      assert_difference('Film.count') do
        post films_url,
          params: {
            film:
            {
              title: 'Chicago',
              runtime: 7,
              external_id: 'https://www.youtube.com/watch?v=QSwvg9Rv2EI'
            }
        }
      end

      assert_redirected_to(films_path)
      assert_equal('Film added', flash[:success])
    end

    test "should not create film if not logged in" do
      assert_no_difference('Film.count') do
        post films_url,
          params: params
      end

      assert_redirected_to(new_user_session_path)
    end

    test "should get create" do
      sign_in_as(:kyle)

      assert_difference('Film.count') do
        post films_url, params: params
      end

      assert_redirected_to(films_path)
      assert_equal('Film added', flash[:success])
    end

  test "should get index" do

  end

  test "should destroy film" do
    sign_in_as(:kyle)

    film = films(:one)
    assert_difference('Film.count', -1) do
      delete film_url(film)
    end

    assert_redirected_to(films_path)
    assert_equal("Film removed", flash[:success])
  end

  test "should fail to destroy due to permissions" do
    sign_in_as(:kyle)

    film = films(:two)
    assert_no_difference('Film.count') do
      delete film_url(film)
    end

    assert_redirected_to(films_path)
    assert_equal('You are not allowed to remove this film', flash[:error])
  end

  test 'admin should be able to destroy any film' do
    sign_in_as(:kyle)

    film = films(:one)
    assert_difference('Film.count', -1) do
      delete film_url(film)
    end

    assert_redirected_to(films_path)
    assert_equal('Film removed', flash[:success])
  end

  test 'should fail due to film not found' do
    sign_in_as(:kyle)

    assert_no_difference('Film.count') do
      delete film_url(999999999999)
    end

    assert_redirected_to(films_path)
    assert_equal('Film not found', flash[:error])
  end

  test 'Runtime numericality failure passed through flash' do
    sign_in_as(:kyle)

    long_runtime = {
      film:
      {
        title: 'Hello',
        runtime: 60,
        external_id: 'https://youtu.be/hello'
      }
    }

    assert_no_difference('Film.count') do
      post films_url, params: long_runtime
    end

    assert_redirected_to(films_path)
    assert_equal('Runtime can only be whole numbers between 0 and 50 minutes.', flash[:error])
  end
end
