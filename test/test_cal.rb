require_relative 'helper'
require_relative '../classes/calendar'

class TestCheersIntegration < MiniTest::Unit::TestCase

  def test_calendar_class_can_take_year
    # shell_output = `ruby cal.rb 2007`
    cal = Calendar.new([2007])
    expected_year = 2007
    assert_equal cal.year, expected_year
  end

  def test_calendar_class_can_take_year_and_month
    cal = Calendar.new([5,2007])
    expected_month = 5
    expected_year = 2007
    assert_equal cal.month, expected_month
    assert_equal cal.year, expected_year
  end

  def test_zeller_12_8_2013
    cal = Calendar.new([12,2013])
    expected_day_of_week = 0 #this means sunday
    assert_equal cal.zeller(8), expected_day_of_week
  end


  def test_zeller_12_8_1800 #far past
    cal = Calendar.new([12,1800])
    expected_day_of_week = 1 #this means sunday
    assert_equal cal.zeller(8), expected_day_of_week
  end

  def test_zeller_3_1_3000 #far future
    cal = Calendar.new([3,3000])
    expected_day_of_week = 6 #this means sunday
    assert_equal cal.zeller(1), expected_day_of_week
  end

  def test_zeller_2_29_2040 #leap day
    cal = Calendar.new([2,2040])
    expected_day_of_week = 3 #this means sunday
    assert_equal cal.zeller(29), expected_day_of_week
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
#     assert_equal shell_output, expected_output
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

# use string =~ /sdfkjljk/
# this takes a string and returns true or false if it is match according to regex




#   def test_a_name_with_no_vowels
#     shell_output = ""
#     IO.popen('ruby cheers.rb', 'r+') do |pipe|
#       pipe.puts("brt")
#       pipe.close_write
#       shell_output = pipe.read
#     end
#     expected_output = <<EOS
# What's your name?
# Give me a... B
# Give me a... R
# Give me a... T
# BRT's just GRAND!
# Your name backwards is trb
# EOS
#     assert_equal shell_output, expected_output
#   end

#   def test_works_for_vowels
#     shell_output = ""
#     IO.popen('ruby cheers.rb', 'r+') do |pipe|
#       pipe.puts("poppa")
#       pipe.close_write
#       shell_output = pipe.read
#     end
#     expected_output = <<EOS
# What's your name?
# Give me a... P
# Give me an... O
# Give me a... P
# Give me a... P
# Give me an... A
# POPPA's just GRAND!
# Your name backwards is appop
# EOS
#     assert_equal shell_output, expected_output
#   end

# #   # But what about names with vowels?!!
