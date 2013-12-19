
class Calendar
  attr_accessor :month, :year
  def initialize(input)
    if input.length == 2
      @month = input[0]
      @year = input[1]
    elsif input.length == 1
      @year = input[0]
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


end