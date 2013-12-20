# add colors!!!! "\e[1;36;44m" #can do 31 - 38 and 41 - 48

require_relative 'classes/calendar'
# passing junk on command line
# ARGV is an array of arguments from command line
cal = Calendar.new(ARGV)
if ARGV.length == 1
  cal.displayYear
elsif ARGV.length == 2
  cal.displayMonth
end










