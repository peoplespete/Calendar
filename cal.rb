# add colors!!!! "\e[1;36;44m" #can do 31 - 38 and 41 - 48

require_relative 'classes/calendar'
# passing junk on command line
# ARGV is an array of arguments from command line
cal = Calendar.new(ARGV)
puts "Month:#{cal.month}"
puts "Year:#{cal.year}"









