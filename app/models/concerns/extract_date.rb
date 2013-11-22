#  Funktion zum Extrahieren eines Datums aus einem String.
module ExtractDate

  POSSIBLE_GERMAN_MONTHS = %w(januar Januar februar Februar märz März april April mai Mai juni Juni juli Juli
     august August september September oktober Oktober november November dezember Dezember
     jan Jan feb Feb apr Apr aug Aug sept Sept okt Okt nov Nov dez Dez)

  def extract_date(string)
    result = nil

    if string.present?
      result = check_string_for_date(string, 'extract_with_german_number_regex')
      result = check_string_for_date(string, 'extract_with_german_month_name_regex')  if result.nil?
      result = check_string_for_date(string, 'extract_with_chronic_de')               if result.nil?
      result = check_string_for_date(string, 'extract_with_chronic')                  if result.nil?
    end

    result
  end


  private

  def check_string_for_date(string, method_name)
    result = nil

    if string.present?
      date_string = self.send(method_name, string)
      result = check_date(date_string)
    end

    result
  end

  def extract_with_german_number_regex(string)
    result = ''

    if string.present?

      # 1.1.2014 or 01.01.2014 or 1.01.14 or ...
      matcher = string.match /([0-9]{1,2})[.]([0-9]{1,2})[.]?([0-9]{0,4})/

      if matcher.present?
        day_string   =  matcher[1]
        month_string =  matcher[2]
        year_string  =  matcher[3]

        result << get_complete_day_or_month_string(day_string, '')
        result << get_complete_day_or_month_string(month_string)
        result << get_complete_year_string(year_string, month_string, day_string)

      end
    end

    result
  end


  def extract_with_german_month_name_regex(string)
    result = ''

    if string.present?

      # 1 Jan 2014 or 26. Okt 2014 or ...
      matcher = string.match /([0-9]{1,2})[.]?[ ]?(#{POSSIBLE_GERMAN_MONTHS.join("|")})[ ]?([0-9]{0,4})/

      if matcher.present?
        day_string   =  matcher[1]
        month_string =  matcher[2]
        year_string  =  matcher[3]

        result << "#{day_string}" if day_string.present?
        result << " #{month_string}" if month_string.present?
        result << get_complete_year_string(year_string, nil, nil, ' ') # Hier nicht month und day string reingeben
      end
      result = Chronic18n.parse(result, :de)
    end

    result
  end

  def extract_with_chronic_de(string)
    Chronic18n.parse(string, :de)
  end

  def extract_with_chronic(string)
    Chronic.parse(string)
  end

  def get_complete_day_or_month_string(string, dot_symbol='.')
    result = ''

    if string.present?
      if string.start_with?('0')
        result << "#{dot_symbol}#{string[1..-1]}"
      else
        result << "#{dot_symbol}#{string}"
      end
    end

    result
  end

  def check_date(date_string)
    result = nil

    if date_string.present?
      begin
        result = date_string.to_date
      rescue ArgumentError
        result = nil
      end
    end

    result
  end

  def get_complete_year_string(year_string, month_string, day_string, dot_symbol='.')
    result = ''

    if year_string.present?
      length = year_string.length
      case length
        when 4
          result << "#{dot_symbol}#{year_string}"
        when 2
          result << "#{dot_symbol}#{(Date.today.year).to_s[0..1]}#{year_string}"
        else
          # Krawumm was dann ?
      end
    else
      # Jahr selbst anhängen
      #Bei Ausfuehrung am 1.7.2013:
      #"1.8. tolles Event www.example.com #event" -> 1.8.2013
      #"1.6. tolles Event www.example.com #event" -> 1.6.2014
      if month_string.present? && day_string.present?
        result = "#{dot_symbol}#{get_presumable_year(month_string, day_string)}"
      end
    end

    result
  end


  def get_presumable_year(month_string, day_string)
    result = ''
    begin
      check_date_string = "#{Date.today.year}-#{month_string}-#{day_string}"
      if Date.today <= check_date_string.to_date
        result = "#{Date.today.year}"
      else
        result = "#{Date.today.year + 1}"
      end
    rescue ArgumentError => e
      result = ''
    end

    result
  end

end