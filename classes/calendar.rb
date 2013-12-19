
class Calendar
  attr_accessor :month, :year

  def initialize(input)
    if input.length == 2
      @month = input[0].to_i
      @year = input[1].to_i
      checkYearInput
    elsif input.length == 1
      @year = input[0].to_i
      checkYearInput
    end
    @leap = false
    if @year % 4 == 0
      if @year % 100 == 0
        @leap = true if @year % 400 == 0
      else
        @leap = true
      end
    end

  end

  def zeller(day)
    zellerMonth = @month
    if @month == 1 or @month == 2
      zellerMonth += 12
      year = @year - 1
    else
      year = @year
    end
    year_in_century = year % 100 #K
    century = (year / 100).floor #J

    quantity1 = day
    quantity2 = (13 * (zellerMonth + 1) / 5).floor
    quantity3 = year_in_century
    quantity4 = (year_in_century / 4).floor
    quantity5 = (century / 4).floor
    quantity6 = 5 * century
    zellerDay = (quantity1 + quantity2 + quantity3 + quantity4 + quantity5 + quantity6) % 7
    (zellerDay + 6) % 7 #adjustment so that my scale begins with Sunday
  end

  def days_in_month
    days_by_month = [31,28,31,30,31,30,31,31,30,31,30,31]
    days_by_month[2 - 1] += 1 if @leap
    days_by_month[@month - 1]
  end

  def checkYearInput
    raise RangeError if @year < 1800 or @year > 3000
  end

end