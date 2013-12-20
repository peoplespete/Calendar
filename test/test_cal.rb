require_relative 'helper'
require_relative '../classes/calendar'

class TestCheersIntegration < MiniTest::Unit::TestCase


  def test_1calendar_class_can_take_year_and_month
    cal = Calendar.new([5,2007])
    expected_month = 5
    expected_year = 2007
    assert_equal expected_month, cal.month
    assert_equal expected_year, cal.year
  end

  def test_2zeller_12_8_2013
    cal = Calendar.new([12,2013])
    expected_day_of_week = 0 #this means sunday
    assert_equal expected_day_of_week, cal.zeller(8)
  end


  def test_3zeller_12_8_1800 #far past
    cal = Calendar.new([12,1800])
    expected_day_of_week = 1
    assert_equal expected_day_of_week, cal.zeller(8)
  end

  def test_4zeller_3_1_3000 #far future
    cal = Calendar.new([3,3000])
    expected_day_of_week = 6
    assert_equal expected_day_of_week, cal.zeller(1)
  end

  def test_5zeller_2_29_2040 #leap day
    cal = Calendar.new([2,2040])
    expected_day_of_week = 3
    assert_equal expected_day_of_week, cal.zeller(29)
  end

  def test_6chooses_correct_number_of_days_in_month
    cal = Calendar.new([9,2013])
    expected_days_in_month = 30
    assert_equal expected_days_in_month, cal.days_in_month
  end

  def test_7chooses_correct_number_of_days_in_month_non_leap_year
    cal = Calendar.new([2,2013])
    expected_days_in_month = 28
    assert_equal expected_days_in_month, cal.days_in_month
  end

  def test_8chooses_correct_number_of_days_in_month_leap_year
    cal = Calendar.new([2,2004])
    expected_days_in_month = 29
    assert_equal expected_days_in_month, cal.days_in_month
  end

  def test_9chooses_correct_number_of_days_in_month_century_leap_year
    cal = Calendar.new([2,2000])
    expected_days_in_month = 29
    assert_equal expected_days_in_month, cal.days_in_month
  end

  def test_10chooses_correct_number_of_days_in_month_non_century_leap_year
    cal = Calendar.new([2,1900])
    expected_days_in_month = 28
    assert_equal expected_days_in_month, cal.days_in_month
  end

  def test_13year_is_output
    shell_output = ""
    IO.popen('ruby cal.rb 1 2012', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output, "2012"
  end

  def test_14month_is_output
    shell_output = ""
    IO.popen('ruby cal.rb 2 2012', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output, "February"
  end

  def test_15month_is_output_first_line
    shell_output = ""
    IO.popen('ruby cal.rb 1 2012', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output, "    January 2012    "
  end

  def test_16month_is_output_first_two_lines
    shell_output = ""
    IO.popen('ruby cal.rb 1 2012', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output, "    January 2012    ", "Su Mo Tu We Th Fr Sa"
  end

  def test_17month_is_output_first_three_lines
    shell_output = ""
    IO.popen('ruby cal.rb 1 2012', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output, "    January 2012    ", "Su Mo Tu We Th Fr Sa", " 1  2  3  4  5  6  7"
  end

  def test_18month_is_output_first_six_lines
    shell_output = ""
    IO.popen('ruby cal.rb 1 2012', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output, "    January 2012    ", "Su Mo Tu We Th Fr Sa", " 1  2  3  4  5  6  7", " 8  9 10 11 12 13 14", "15 16 17 18 19 20 21", "22 23 24 25 26 27 28"
  end



#   def test_a_month_display
#     shell_output = `ruby cal.rb 1 2012`
#     expected_output = <<EOS
#     January 2012
# Su Mo Tu We Th Fr Sa
#  1  2  3  4  5  6  7
#  8  9 10 11 12 13 14
# 15 16 17 18 19 20 21
# 22 23 24 25 26 27 28
# 29 30 31
# EOS
#     assert_equal expected_output, shell_output
#   end

#   def test_a_february_display
#     shell_output = `ruby cal.rb 2 2012`
#     expected_output = <<EOS
# February 2012
# EOS
#     assert_equal expected_output, shell_output
#   end




  # def test_0calendar_class_can_take_year
  #   # shell_output = `ruby cal.rb 2007`
  #   cal = Calendar.new([2007])
  #   expected_year = 2007
  #   assert_equal expected_year, cal.year
  # end

  # def test_11refuses_year_before_1800
  #   assert_raises RangeError do
  #     cal = Calendar.new([1799])
  #   end
  # end

  # def test_12refuses_year_after_3000
  #   assert_raises RangeError do
  #     cal = Calendar.new([3001])
  #   end
  # end

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



