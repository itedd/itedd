#  Funktion zum Extrahieren eines Datums aus einem String.
require 'pp'
module ExtractDate

  def extract(string)
    result = ''

    if string.present?
      matcher = string.match /([1-9]|0[1-9]|[12][0-9]|3[01])[-\.]([1-9]|0[1-9]|1[012])[-\.]([1-9][0-9][0-9][0-9]|[1-9][0-9])/

      day_string   =  matcher[1]
      month_string =  matcher[2]
      year_string  =  matcher[3]


      # refactoring
      if day_string.present?
        if day_string.start_with?('0')
          result << "#{day_string[1..-1]}"
        else
          result << "#{day_string}"
        end
      end
      # refactoring
      if month_string.present?
        if month_string.start_with?('0')
          result << ".#{month_string[1..-1]}"
        else
          result << ".#{month_string}"
        end
      end

      if year_string.present?
        length = year_string.length
        if length == 4
          result << ".#{year_string}"
        elsif length == 2
          #todo universeller machen, gilt erstmal nur 2000 bis 2099
          result << ".20#{year_string}"
        else
          # Krawumm was dann ?
        end

      end

    end

    result
  end

end