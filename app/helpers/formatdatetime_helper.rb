module FormatdatetimeHelper

  # February
  def format_month(date)
    date.strftime("%B")
  end

  # Wednesday
  def formatDayofWeek(date)
    date.strftime("%A")
  end

  # 2020
  def formatYear(date)
    date.strftime("%Y")
  end

  # Feb.23.2018
  def format_date_month(date)
    date.strftime("%b.%d.%Y")
  end

  # Tuesday, October 10, 2017
  def formatFullDate(date)
    date.strftime("%A | %B #{date.day.ordinalize}, %Y")
  end
  # 9/19
  def formatMonthDayDate(date)
    date.strftime("%-m/%-d")
  end
  # 9/19/17
  def formatDate(date)
    date.strftime("%-m/%-d/%y")
  end
  # 9.19
  def formatMonthDateDots(date)
    date.strftime("%-m.%-d")
  end
  # 9.19.17
  def formatDateDots(date)
    date.strftime("%-m.%-d.%y")
  end
  # 9/19
  def formatCalendarDay(date)
    date.strftime("%-m/%-d")
  end
  # 12/28-1/3/21
  def formatDateRange(start_date, end_date)
    formatMonthDayDate(start_date) + "-" + formatDate(end_date)
  end
  # December 2020
  def formatMonthYear(start_date, end_date)
    format_month(start_date) + " " + formatYear(end_date)
  end

  # 4:38pm
  def formatTime(date)
    date.strftime("%-I:%M%p")
  end
  # 4:38pm - 5:38pm
  def formatTimeRange(record)
    record.start_time.strftime("%-I:%M%p") + " - " + record.end_time.strftime("%-I:%M%p")
  end

  # Jul. 31 - Aug. 2, 2020
  def formatshortenedDateRange(startdate, enddate)
    startdate.strftime("%b. %-d") + " - " + enddate.strftime("%b. %-d, %Y")
  end

  # July 31 - August 2, 2020
  def formatFullDateRange(startdate, enddate)
    startdate.strftime("%B %-d") + " - " + enddate.strftime("%B %-d, %Y")
  end

  # 09/19/17 04:38pm
  def formatDateTime(date)
    date.strftime("%m/%d/%y %I:%M%p")
  end

  # 9/19/17 at 4:38pm
  def formateDateTimeWithAt(date)
    date.strftime("%-m/%-d/%y at %-I:%M%p")
  end

  def formatYear(date)
    date.strftime("%-Y")
  end

end