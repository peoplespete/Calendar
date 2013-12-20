
class Calendar
  attr_accessor :month, :month_name, :year
  WIDTH_OF_MONTH_DISPLAY = 20
  WIDTH_OF_YEAR_DISPLAY = 64
  NUMBER_OF_MONTHS_TO_DISPLAY_ON_ONE_LINE = 3
  def initialize(input)
    if input.length == 2
      @month = input[0].to_i
      @year = input[1].to_i
      checkYearInput
    elsif input.length == 1
      @year = input[0].to_i
      checkYearInput
    else
      raise ArgumentError
    end
    @leap = false
    if @year % 4 == 0
      if @year % 100 == 0
        @leap = true if @year % 400 == 0
      else
        @leap = true
      end
    end
    if @month
      month_name = nameMonth
      @month_display_array = createMonth(@month, month_name)
    else
      # put in loop through months here to createLines in year
      @year_display_array = createYear

    end
  end

  def createYear
    # must make an array of 1 - 12
    # nameMonth
    # createDayArray
    year_display = []
    12.times do |i|
      month_name = nameMonth(i+1)
      includeYear = false
      year_display << createMonth(i+1, month_name, includeYear)
    end
    year_display #array of month_display arrays
  end

  def displayYear
    #NOW INTERWEAVE THEM!!!
    puts spacingPayload(nil, @year)
    year_display_array = @year_display_array
    month_display_height = year_display_array[0].length
    4.times do
      blob = []
      NUMBER_OF_MONTHS_TO_DISPLAY_ON_ONE_LINE.times do
        blob << year_display_array[0]
        year_display_array.shift
      end

      month_display_height.times do
        blob.each do |month_display_array|
          print month_display_array[0]
          month_display_array.shift
        end
        puts ""
      end
      puts ""
    end
  end

  def createMonth(month, month_name, includeYear = true)
    dayArrayStrings = createDayArray(month)
    month_display = []
    # puts @dayArrayStrings
    # dayArrayStrings = @dayArrayStrings

    first_line = spacingPayload(month_name, @year) if includeYear
    first_line = spacingPayload(month_name) unless includeYear
    first_line = first_line << "  "
    month_display << first_line

    second_line = "Su Mo Tu We Th Fr Sa"
    second_line = second_line << "  "
    month_display << second_line

    third_line = ""
    starting_place = zeller(1, month)
    (starting_place).times do
      third_line << "  " #empty spot
      third_line << " "
    end
    (7-starting_place).times do
      third_line << dayArrayStrings[0]
      third_line << " "
      dayArrayStrings.shift
    end
    third_line = third_line << " "
    month_display << third_line

    fourth_line = makeFullLine(dayArrayStrings)
    month_display << fourth_line

    fifth_line = makeFullLine(dayArrayStrings)
    month_display << fifth_line

    sixth_line = makeFullLine(dayArrayStrings)
    month_display << sixth_line

    #7th and 8th lines may or may contain days each month
    if dayArrayStrings.length > 7
      # do 7th and 8th lines
      seventh_line = makeFullLine(dayArrayStrings)
      month_display << seventh_line

      eighth_line = ""
      spaces_needed = 7 - dayArrayStrings.length
      (dayArrayStrings.length).times do
        eighth_line << dayArrayStrings[0]
        eighth_line << " "
        dayArrayStrings.shift
      end
      spaces_needed.times do
        eighth_line << "  "
        eighth_line << " "
      end
      eighth_line = eighth_line << " "
      month_display << eighth_line
    else
      if dayArrayStrings.length > 0
        # do 7th line
        seventh_line = ""
        spaces_needed = 7 - dayArrayStrings.length
        (dayArrayStrings.length).times do
          seventh_line << dayArrayStrings[0]
          seventh_line << " "
          dayArrayStrings.shift
        end
        spaces_needed.times do
          seventh_line << "  "
          seventh_line << " "
        end
        seventh_line = seventh_line << " "
        month_display << seventh_line
      else
        seventh_line = makeEmptyLine << "  "
        month_display << seventh_line
      end
      eighth_line = makeEmptyLine << "  "
      month_display << eighth_line
    end
    month_display
  end

  def displayMonth
    @month_display_array.each do |line|
      puts line
    end

  end

  def zeller(day, month = @month)
    zellerMonth = month
    if month == 1 or month == 2
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

  def days_in_month(month = @month)
    days_by_month = [31,28,31,30,31,30,31,31,30,31,30,31]
    days_by_month[2 - 1] += 1 if @leap
    days_by_month[month - 1]
  end

  def checkYearInput
    raise RangeError if @year < 1800 or @year > 3000
  end

  def nameMonth(month = @month)
    month_names = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
    month_names[month - 1] unless month > 12 or month < 1
  end

  def spacingPayload(month = nil, year = nil)
    if month
      if year
        payload = "#{month} #{year}"
        displayWidth = WIDTH_OF_MONTH_DISPLAY
      else
        payload = "#{month}"
        displayWidth = WIDTH_OF_MONTH_DISPLAY
      end
    else
      payload = "#{year}" unless month
      displayWidth = WIDTH_OF_YEAR_DISPLAY
    end
    remainingSpace = displayWidth - payload.length

    if remainingSpace % 2 == 0
      beforeSpacesNum = remainingSpace / 2
      afterSpacesNum = remainingSpace / 2
    else
      beforeSpacesNum = (remainingSpace / 2).floor
      afterSpacesNum = (remainingSpace / 2).floor + 1
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

  def makeFullLine(dayArrayStrings)
    line = ""
    7.times do
      line << dayArrayStrings[0]
      line << " "
      dayArrayStrings.shift
    end
    line = line << " "
  end

  def makeEmptyLine
    line = ""
    WIDTH_OF_MONTH_DISPLAY.times do
      line << " "
    end
    line
  end

  def createDayArray(month)
    dayArray = (1..days_in_month(month)).to_a
    dayArrayStrings = dayArray.collect do |day|
      if day < 10
        " " << day.to_s
      else
        day.to_s
      end
    end
    dayArrayStrings
  end





end