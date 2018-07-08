require 'test_helper'

class ApplausesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'adds applause for film' do
    film = films(:one)
    user = users(:john)
    sign_in(user)

    params = { film: film.id, category: 'directing' }

    assert_difference('Applause.count') do
      post film_applauses_url(film.id), params: params
    end

    last_applause = film.applauses.last
    assert_equal(last_applause.user, user)
    assert_equal(last_applause.category, 'directing')
  end
  
  test 'destroys applause' do
    film = films(:one)
    user = users(:john)
    sign_in(user)

    applause = Applause.create(film: film, user: user, category: 'story')

    assert_difference('Applause.count', -1) do
      delete film_applause_url(film.id, applause.id)
    end
  end

  test 'fails on duplicate' do
    film = films(:one)
    user = users(:john)
    sign_in(user)

    params = { film: film.id, user: user.id, category: 'sound' }
    Applause.create(film: film, user: user, category: 'sound')

    assert_no_difference('Applause.count') do
      post film_applauses_url(film.id), params: params
    end
  end

  test 'user can not delete another users' do
    film = films(:one)
    user1 = users(:kyle)
    user2 = users(:john)
    sign_in(user1)

    applause = Applause.create(film: film, user: user2, category: 'acting')

    assert_no_difference('Applause.count') do
      delete film_applause_url(film.id, applause.id)
    end
  end

  test 'requires user to be logged in' do
    params = {film: films(:one), category: 'directing'}

    post film_applauses_url(films(:one).id), params: params

    assert_redirected_to(new_user_session_path)
  end

  test 'trying to destroy missing record' do
    film = films(:one)
    user = users(:kyle)
    sign_in(user)

    assert_no_difference('Applause.count') do
      delete film_applause_url(film.id, 999999999999999)
    end
  end
end
