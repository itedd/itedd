#  Funktion zum Extrahieren eines Datums aus einem String.
require 'pp'
module ExtractDate

  def extract(string)
    result = ''

    if string.present?
      result = extract_with_numbers(string)
      result = check_date(result)

      result = extract_with_prosa(string) if result.nil?
      result = check_date(result)
    end

    result
  end



  private

  def extract_with_numbers(string)
    result = ''

    if string.present?

      matcher = string.match /([1-9]|0[1-9]|[12][0-9]|3[01])[-\.]([1-9]|0[1-9]|1[012])[-\.]([1-9][0-9][0-9][0-9]|[1-9][0-9])/

      day_string   =  matcher[1]
      month_string =  matcher[2]
      year_string  =  matcher[3]

      if day_string.present?
        if day_string.start_with?('0')
          result << "#{day_string[1..-1]}"
        else
          result << "#{day_string}"
        end
      end

      if month_string.present?
        if month_string.start_with?('0')
          result << ".#{month_string[1..-1]}"
        else
          result << ".#{month_string}"
        end
      end

      if year_string.present?
        length = year_string.length
        case length
          when 4
            result << ".#{year_string}"
          when 2
            #todo universeller machen, gilt erstmal nur 2000 bis 2099
            result << ".20#{year_string}"
          else
            # Krawumm was dann ?
        end
      else
        # Jahr selbst anhängen
        #Bei Ausfuehrung am 1.7.2013:
        #"1.8. tolles Event www.example.com #event" -> 1.8.2013
        #"1.6. tolles Event www.example.com #event" -> 1.6.2014
      end
    end

    result
  end

  def extract_with_prosa(string)
    # TODO z.B. '1. Mai ' oder  'Erster Januar' erkennen
    result = ''
  end

  def check_date(date_string)
    result = nil

    if date_string.present?
      begin
        date_string.to_date
        result = date_string
      rescue ArgumentError
        result = nil
      end
    end

    result
  end

end