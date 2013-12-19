require_relative 'helper'
require_relative '../classes/calendar'

class TestCheersIntegration < MiniTest::Unit::TestCase

  def test_calendar_class_can_take_year
    # shell_output = `ruby cal.rb 2007`
    cal = Calendar.new([2007])
    expected_year = 2007
    assert_equal expected_year, cal.year
  end

  def test_calendar_class_can_take_year_and_month
    cal = Calendar.new([5,2007])
    expected_month = 5
    expected_year = 2007
    assert_equal expected_month, cal.month
    assert_equal expected_year, cal.year
  end

  def test_zeller_12_8_2013
    cal = Calendar.new([12,2013])
    expected_day_of_week = 0 #this means sunday
    assert_equal expected_day_of_week, cal.zeller(8)
  end


  def test_zeller_12_8_1800 #far past
    cal = Calendar.new([12,1800])
    expected_day_of_week = 1
    assert_equal expected_day_of_week, cal.zeller(8)
  end

  def test_zeller_3_1_3000 #far future
    cal = Calendar.new([3,3000])
    expected_day_of_week = 6
    assert_equal expected_day_of_week, cal.zeller(1)
  end

  def test_zeller_2_29_2040 #leap day
    cal = Calendar.new([2,2040])
    expected_day_of_week = 3
    assert_equal expected_day_of_week, cal.zeller(29)
  end

  def test_chooses_correct_number_of_days_in_month
    cal = Calendar.new([9,2013])
    expected_days_in_month = 30
    assert_equal expected_days_in_month, cal.days_in_month
  end

  def test_chooses_correct_number_of_days_in_month_non_leap_year
    cal = Calendar.new([2,2013])
    expected_days_in_month = 28
    assert_equal expected_days_in_month, cal.days_in_month
  end

  def test_chooses_correct_number_of_days_in_month_leap_year
    cal = Calendar.new([2,2004])
    expected_days_in_month = 29
    assert_equal expected_days_in_month, cal.days_in_month
  end

  def test_chooses_correct_number_of_days_in_month_century_leap_year
    cal = Calendar.new([2,2000])
    expected_days_in_month = 29
    assert_equal expected_days_in_month, cal.days_in_month
  end

  def test_chooses_correct_number_of_days_in_month_non_century_leap_year
    cal = Calendar.new([2,1900])
    expected_days_in_month = 28
    assert_equal expected_days_in_month, cal.days_in_month
  end

  def test_refuses_year_before_1800
    assert_raises RangeError do
      cal = Calendar.new([1799])
    end
  end

  def test_refuses_year_after_3000
    assert_raises RangeError do
      cal = Calendar.new([3001])
    end
  end










#   def test_a_name_with_no_vowels
#     shell_output = `ruby cheers.rb brt`
#     expected_output = <<EOS
# What's your name?
# Give me a... B
# Give me a... R
# Give me a... T
# BRT's just GRAND!
# Your name backwards is trb
# EOS
#     assert_equal expected_output, shell_output
#   end

#   def test_reverse_your_name
#     shell_output = ""
#     IO.popen('ruby cheers.rb', 'r+') do |pipe|
#       pipe.puts("pete")
#       pipe.close_write
#       shell_output = pipe.read
#     end
#     assert_includes_in_order shell_output, "etep"
#   end

end



