ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/autorun'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def sign_in_as(user)
    user = users(user)
    sign_in(user)
    user
  end

  def sign_in_from_view(user, password)
    user = users(user)

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: password
    click_on 'Log in'
  end
end
