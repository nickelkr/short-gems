require 'test_helper'

class ApplauseTest < ActiveSupport::TestCase
  test 'allowed categories' do
    CATEGORIES = %w[directing story cinematography sound acting]

    CATEGORIES.each do |category|
      assert_difference('Applause.count') do
        Applause.create({user: users(:kyle), film: films(:two), category: category})
      end
    end

    assert_equal([], CATEGORIES - Applause.all.map(&:category))
  end

  test 'fails on non-allowed category' do
    assert_raise(ArgumentError, "'red-herring' is not a valid category") do
      Applause.create({user: users(:kyle), film: films(:two), category: 'red-herring'})
    end
  end

  test 'only one per user per category' do
    params = {user: users(:kyle), film: films(:two), category: 'story'}
    Applause.create(params)

    assert_no_difference('Applause.count') do
      Applause.create(params)
    end
  end
end
