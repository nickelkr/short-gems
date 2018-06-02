require 'test_helper'

class FilmsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get films_create_url
    assert_response :success
  end

  test "should get index" do
    get films_index_url
    assert_response :success
  end

  test "should get destroy" do
    get films_destroy_url
    assert_response :success
  end

  test "should get new" do
    get films_new_url
    assert_response :success
  end

end
