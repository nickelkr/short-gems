require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  test '#admin? w/ active account' do
    user = users(:admin)
    assert(user.roles.admin?)
  end

  test '#admin? w/ deactivated_account' do
    user = users(:john)

    assert_not(user.roles.admin?)
  end

  test '#admin? w/ normal account' do
    user = users(:kyle)

    assert_not(user.roles.admin?)
  end
end
