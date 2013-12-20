require_relative 'helper'
require_relative '../classes/calendar'

class TestCheersIntegration < MiniTest::Unit::TestCase

  def test_0user_must_supply_at_least_one_argument
    assert_raises ArgumentError do
      cal = Calendar.new
    end
  end


############################################################################################
# Month Calendar

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

  def test_4azeller_3_1_3000 #far future
    cal = Calendar.new([3,3000])
    expected_day_of_week = 6
    assert_equal expected_day_of_week, cal.zeller(1)
  end

def test_4brefuses_year_before_1800
    assert_raises RangeError do
      cal = Calendar.new([3, 1799])
    end
  end

  def test_4crefuses_year_after_3000
    assert_raises RangeError do
      cal = Calendar.new([12, 3001])
    end
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

  def test_19a_month_display
    shell_output = ""
    IO.popen('ruby cal.rb 1 2012', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output, "    January 2012    ", "Su Mo Tu We Th Fr Sa", " 1  2  3  4  5  6  7", " 8  9 10 11 12 13 14", "15 16 17 18 19 20 21", "22 23 24 25 26 27 28", "29 30 31            "
  end

  def test_20a_month_display_leap_year_february
    shell_output = ""
    IO.popen('ruby cal.rb 2 2012', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output, "   February 2012      ", "Su Mo Tu We Th Fr Sa  ", "          1  2  3  4  ", " 5  6  7  8  9 10 11  ", "12 13 14 15 16 17 18  ", "19 20 21 22 23 24 25  ", "26 27 28 29           "
  end

  def test_21a_month_display_six_rows
    shell_output = ""
    IO.popen('ruby cal.rb 2 2015', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output, "   February 2015      ", "Su Mo Tu We Th Fr Sa  ", " 1  2  3  4  5  6  7  ", " 8  9 10 11 12 13 14  ", "15 16 17 18 19 20 21  ", "22 23 24 25 26 27 28  "
  end

  def test_22a_month_display_eight_rows
    shell_output = ""
    IO.popen('ruby cal.rb 9 2012', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output, "   September 2012     ", "Su Mo Tu We Th Fr Sa  ", "                   1  ", " 2  3  4  5  6  7  8  ", " 9 10 11 12 13 14 15  ", "16 17 18 19 20 21 22  ", "23 24 25 26 27 28 29  ", "30                    "
  end

############################################################################################
# Annual Calendar

  def test_23calendar_class_can_take_year
    # shell_output = `ruby cal.rb 2007`
    cal = Calendar.new([2007])
    expected_year = 2007
    assert_equal expected_year, cal.year
  end

  def test_24arefuses_year_before_1800
    assert_raises RangeError do
      cal = Calendar.new([1799])
    end
  end

  def test_24brefuses_year_after_3000
    assert_raises RangeError do
      cal = Calendar.new([3001])
    end
  end

def test_25year_is_output_first_line
    shell_output = ""
    IO.popen('ruby cal.rb 2012', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output, "                            2012"
  end

  def test_26year_is_output_first_two_lines
    shell_output = ""
    IO.popen('ruby cal.rb 2012', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output, "                            2012", "      January               February               March          "
  end

  def test_27year_is_output_first_three_lines
    shell_output = ""
    IO.popen('ruby cal.rb 2012', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output, "                            2012", "      January               February               March          ", "Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  "
  end

  def test_28year_is_output_first_four_lines
    shell_output = ""
    IO.popen('ruby cal.rb 2012', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output, "                            2012", "      January               February               March          ", "Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  ", " 1  2  3  4  5  6  7            1  2  3  4               1  2  3  "
  end

  def test_29full_year_output
    shell_output = ""
    IO.popen('ruby cal.rb 2012', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output, "                            2012", "      January               February               March          ", "Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  ", " 1  2  3  4  5  6  7            1  2  3  4               1  2  3  ", " 8  9 10 11 12 13 14   5  6  7  8  9 10 11   4  5  6  7  8  9 10  ", "15 16 17 18 19 20 21  12 13 14 15 16 17 18  11 12 13 14 15 16 17  ", "22 23 24 25 26 27 28  19 20 21 22 23 24 25  18 19 20 21 22 23 24  ", "29 30 31              26 27 28 29           25 26 27 28 29 30 31  ", "       April                  May                   June          ", "Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  ", " 1  2  3  4  5  6  7         1  2  3  4  5                  1  2  ", " 8  9 10 11 12 13 14   6  7  8  9 10 11 12   3  4  5  6  7  8  9  ", "15 16 17 18 19 20 21  13 14 15 16 17 18 19  10 11 12 13 14 15 16  ", "22 23 24 25 26 27 28  20 21 22 23 24 25 26  17 18 19 20 21 22 23  ", "29 30                 27 28 29 30 31        24 25 26 27 28 29 30  ", "        July                 August              September        ", "Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  ", " 1  2  3  4  5  6  7            1  2  3  4                     1  ", " 8  9 10 11 12 13 14   5  6  7  8  9 10 11   2  3  4  5  6  7  8  ", "15 16 17 18 19 20 21  12 13 14 15 16 17 18   9 10 11 12 13 14 15  ", "22 23 24 25 26 27 28  19 20 21 22 23 24 25  16 17 18 19 20 21 22  ", "29 30 31              26 27 28 29 30 31     23 24 25 26 27 28 29  ", "                                            30                    ", "      October               November              December        ", "Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  ", "    1  2  3  4  5  6               1  2  3                     1  ", " 7  8  9 10 11 12 13   4  5  6  7  8  9 10   2  3  4  5  6  7  8  ", "14 15 16 17 18 19 20  11 12 13 14 15 16 17   9 10 11 12 13 14 15  ", "21 22 23 24 25 26 27  18 19 20 21 22 23 24  16 17 18 19 20 21 22  ", "28 29 30 31           25 26 27 28 29 30     23 24 25 26 27 28 29  ", "                                            30 31                 "
  end


  # def test_27month_is_output_first_three_lines
  #   shell_output = ""
  #   IO.popen('ruby cal.rb 1 2012', 'r+') do |pipe|
  #     pipe.close_write
  #     shell_output = pipe.read
  #   end
  #   assert_includes_in_order shell_output, "    January 2012    ", "Su Mo Tu We Th Fr Sa", " 1  2  3  4  5  6  7"
  # end

  # def test_28month_is_output_first_six_lines
  #   shell_output = ""
  #   IO.popen('ruby cal.rb 1 2012', 'r+') do |pipe|
  #     pipe.close_write
  #     shell_output = pipe.read
  #   end
  #   assert_includes_in_order shell_output, "    January 2012    ", "Su Mo Tu We Th Fr Sa", " 1  2  3  4  5  6  7", " 8  9 10 11 12 13 14", "15 16 17 18 19 20 21", "22 23 24 25 26 27 28"
  # end

  # def test_29a_month_display
  #   shell_output = ""
  #   IO.popen('ruby cal.rb 1 2012', 'r+') do |pipe|
  #     pipe.close_write
  #     shell_output = pipe.read
  #   end
  #   assert_includes_in_order shell_output, "    January 2012    ", "Su Mo Tu We Th Fr Sa", " 1  2  3  4  5  6  7", " 8  9 10 11 12 13 14", "15 16 17 18 19 20 21", "22 23 24 25 26 27 28", "29 30 31            "
  # end

  # def test_30a_month_display_leap_year_february
  #   shell_output = ""
  #   IO.popen('ruby cal.rb 2 2012', 'r+') do |pipe|
  #     pipe.close_write
  #     shell_output = pipe.read
  #   end
  #   assert_includes_in_order shell_output, "   February 2012      ", "Su Mo Tu We Th Fr Sa  ", "          1  2  3  4  ", " 5  6  7  8  9 10 11  ", "12 13 14 15 16 17 18  ", "19 20 21 22 23 24 25  ", "26 27 28 29           "
  # end

  # def test_31a_month_display_six_rows
  #   shell_output = ""
  #   IO.popen('ruby cal.rb 2 2015', 'r+') do |pipe|
  #     pipe.close_write
  #     shell_output = pipe.read
  #   end
  #   assert_includes_in_order shell_output, "   February 2015      ", "Su Mo Tu We Th Fr Sa  ", " 1  2  3  4  5  6  7  ", " 8  9 10 11 12 13 14  ", "15 16 17 18 19 20 21  ", "22 23 24 25 26 27 28  "
  # end

  # def test_32a_month_display_eight_rows
  #   shell_output = ""
  #   IO.popen('ruby cal.rb 9 2012', 'r+') do |pipe|
  #     pipe.close_write
  #     shell_output = pipe.read
  #   end
  #   assert_includes_in_order shell_output, "   September 2012     ", "Su Mo Tu We Th Fr Sa  ", "                   1  ", " 2  3  4  5  6  7  8  ", " 9 10 11 12 13 14 15  ", "16 17 18 19 20 21 22  ", "23 24 25 26 27 28 29  ", "30                    "
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



