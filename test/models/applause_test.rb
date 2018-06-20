require 'test_helper'

class ApplauseTest < ActiveSupport::TestCase
  test 'allowed categories' do
    CATEGORIES = %w[directing story cinematography sound acting]

    CATEGORIES.each do |category|
      assert_difference('Applause.count') do
        Applause.create({user: users(:kyle), film: films(:two), category: category})
      end
    end
  end

  test 'fails on non-allowed category' do
    assert_no_difference('Applause.count') do
      Applause.create({user: users(:kyle), film: films(:two), category: 'red-herring'})
    end
  end
end
