require 'test_helper'

class ExtractDateTest < ActiveSupport::TestCase

  setup do
    object_class = Class.new
    object_class.send(:include, ExtractDate)
    @date_extractor = object_class.new
  end

  def self.get_expected_date_with_year(month_day_string)
     if Date.today < "#{month_day_string}#{Date.today.year}".to_date
       "#{month_day_string}#{Date.today.year}"
     else
       "#{month_day_string}#{Date.today.year + 1}"
     end
  end


  #german_month_name_tests = {}
  #%w(januar Januar februar Februar märz März april April mai Mai juni Juni juli Juli
  #   august August september September oktober Oktober november November dezember Dezember
  #   jan Jan feb Feb apr Apr aug Aug sept Sept okt Okt nov Nov dez Dez)..collect{|i| t["26.#{i}"] = "efe"; t["26 #{i}"] = "efe"}

  {
      '1.1.2014' => '01.01.2014',
      '1.1.2014 19Uhr' => '01.01.2014',
      '1.1.14 19Uhr' => '01.01.2014',
      '1.01.2014 19Uhr' => '01.01.2014',
      '01.01.2014 19Uhr' => '01.01.2014',
      '1.1.2014 1900' => '01.01.2014',
      '1.1.2014 19:00' => '01.01.2014',

      '1979-05-27' => '27.05.1979',

      '5/27/1979' => '27.05.1979',
      '7 days from now' => (Date.today + 7.days).to_s,
      'in seven days' => (Date.today + 7.days).to_s,
      'in 7 days' => (Date.today + 7.days).to_s,
      '3 jan 2000' => '03.01.2000',
      '17 april 85' => '17.04.1985',
      '5th may 2017' => '05.05.2017',
      'may 27th' => get_expected_date_with_year('27.05.'),
      '22nd of june' => get_expected_date_with_year('22.06.'),

      '29.02.2012' => '29.02.2012',
      '29.02.2013' => nil,

      #'1. Mai' => get_expected_date_with_year('01.05.'), # TODO soeren 20.11.13 test mit ruby 2.0
      'Erster Januar' => get_expected_date_with_year('01.01.'),
      #'26. Okt' => get_expected_date_with_year('26.10.'),
      '26 Okt' => get_expected_date_with_year('26.10.'),
      '26 okt' => get_expected_date_with_year('26.10.'),
      '26 Oktober' => get_expected_date_with_year('26.10.'),
      '26 oktober' => get_expected_date_with_year('26.10.'),
      #'26. Okt' => get_expected_date_with_year('26.10.'),
      '26 Okt' => get_expected_date_with_year('26.10.'),
      '26 okt' => get_expected_date_with_year('26.10.'),
      '26 Oktober' => get_expected_date_with_year('26.10.'),
      '26 oktober' => get_expected_date_with_year('26.10.'),

  }.each do |current_date_string, expected_date_string|

    test "should extract date: #{current_date_string}" do
      expected_date = expected_date_string
      expected_date = expected_date_string.to_date unless expected_date.nil?

      assert_equal(expected_date, @date_extractor.extract("#{current_date_string} tolles Event www.example.com #event"))
      assert_equal(expected_date, @date_extractor.extract("tolles Event #{current_date_string} www.example.com#event"))
      assert_equal(expected_date, @date_extractor.extract("tolles Event www.example.com #event #{current_date_string}"))

=begin
    Das Datum muss nicht vollstaendig sein, es wird ggf. um das aktuelle oder das kommende Jahr ergaenzt. ("Naechste Gelegenheit")

    Bei Ausfuehrung am 1.7.2013:
        "1.8. tolles Event www.example.com #event" -> 1.8.2013
    "1.6. tolles Event www.example.com #event" -> 1.6.2014


=end
    end

  end

end