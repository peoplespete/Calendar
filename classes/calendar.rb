
class Calendar
  attr_accessor :month, :month_name, :year
  WIDTH_OF_MONTH_DISPLAY = 20
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
    nameMonth
    createDayArray
  end

  def displayMonth
    first_line = spacingPayload(@month_name, @year)
    puts first_line
    second_line = "Su Mo Tu We Th Fr Sa"
    puts second_line
    # @dayArrayStrings
    third_line = ""
    dayArrayStrings = @dayArrayStrings
    starting_place = zeller(1)
    (starting_place).times do
      third_line << "  " #empty spot
      third_line << " "
    end
    (7-starting_place).times do
      third_line << dayArrayStrings[0]
      third_line << " "
      dayArrayStrings.shift
    end
    puts third_line
    fourth_line = ""
    7.times do
      fourth_line << dayArrayStrings[0]
      fourth_line << " "
      dayArrayStrings.shift
    end
    puts fourth_line
    fifth_line = ""
    7.times do
      fifth_line << dayArrayStrings[0]
      fifth_line << " "
      dayArrayStrings.shift
    end
    puts fifth_line
    sixth_line = ""
    7.times do
      sixth_line << dayArrayStrings[0]
      sixth_line << " "
      dayArrayStrings.shift
    end
    puts sixth_line



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
    days_by_month[@month - 1] if @month
  end

  def checkYearInput
    raise RangeError if @year < 1800 or @year > 3000
  end

  def nameMonth
    month_names = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
    @month_name = month_names[@month - 1] unless !@month or @month > 12 or @month < 1
  end

  def spacingPayload(month = nil, year)
    payload = "#{month} #{year}" if month
    remainingSpace = WIDTH_OF_MONTH_DISPLAY - payload.length

    if remainingSpace % 2 == 0
      beforeSpacesNum = remainingSpace / 2
      afterSpacesNum = remainingSpace / 2
    else
      beforeSpacesNum = (remainingSpace / 2).floor
      afterSpacesNum = (remainingSpace / 2).ceil
    end
    beforeSpaces = ""
    afterSpaces = ""
    beforeSpacesNum.times do
      beforeSpaces = beforeSpaces << " "
    end
    first_line = beforeSpaces << payload
    afterSpacesNum.times do
      afterSpaces = afterSpaces << " "
    end
    first_line = first_line << afterSpaces
    first_line
  end

  def createDayArray
    @dayArray = (1..days_in_month).to_a
    @dayArrayStrings = @dayArray.collect do |day|
      if day < 10
        " " << day.to_s
      else
        day.to_s
      end
    end
  end










end