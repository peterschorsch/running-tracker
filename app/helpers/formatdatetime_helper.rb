module FormatdatetimeHelper

  # Feb.23.2018
  def format_date_month(date)
    date.strftime("%b.%d.%Y")
  end

  # Tuesday, October 10, 2017
  def formatFullDate(date)
    date.strftime("%A, %B %d, %Y")
  end
  # 9/19/17
  def formatDate(date)
    date.strftime("%-m/%-d/%y")
  end
  # 9.19.17
  def formatDateDots(date)
    date.strftime("%-m.%-d.%y")
  end
  # 4:38pm
  def formatTime(date)
    date.strftime("%-I:%M%p")
  end

  # Jul 31 - Aug. 2, 2020
  def formatDateRange(startdate, enddate)
    startdate.strftime("%B %d") + " - " + enddate.strftime("%B %d, %Y")
  end

  # 09/19/17 04:38pm
  def formatDateTime(date)
    date.strftime("%m/%d/%y %I:%M%p")
  end

  # 9/19/17 at 4:38pm
  def formateDateTimeWithAt(date)
    date.strftime("%-m/%d/%y at %-I:%M%p")
  end

end