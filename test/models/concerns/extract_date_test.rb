require 'test_helper'

class ExtractDateTest < ActiveSupport::TestCase

  setup do
    object_class = Class.new
    object_class.send(:include, ExtractDate)
    @date_extractor = object_class.new
  end

  def self.get_expected_date_with_year(month_day_string)
     if Date.today <= "#{month_day_string}#{Date.today.year}".to_date
       "#{month_day_string}#{Date.today.year}"
     else
       "#{month_day_string}#{Date.today.year + 1}"
     end
  end


  german_month_name_tests = {}
  ExtractDate::POSSIBLE_GERMAN_MONTHS.collect do |i|

    this_year    = Date.today.year
    next_year    = this_year + 1
    month_number = Chronic18n.parse(i, :de).to_date.month

    german_month_name_tests["26. #{i} #{this_year}"] = "26.#{month_number}.#{this_year}"
    german_month_name_tests["26 #{i} #{this_year}"]  = "26.#{month_number}.#{this_year}"
    german_month_name_tests["26. #{i} #{next_year}"] = "26.#{month_number}.#{next_year}"
    german_month_name_tests["26 #{i} #{next_year}"]  = "26.#{month_number}.#{next_year}"
    german_month_name_tests["26 #{i}"]  = get_expected_date_with_year("26.#{month_number}.")
    german_month_name_tests["26. #{i}"]  = get_expected_date_with_year("26.#{month_number}.")
  end

  german_month_name_tests.merge({
      '1.1.2014'         => '01.01.2014',
      '31.12.2014'       => '31.12.2014',
      '1.1.2014 19Uhr'   => '01.01.2014',
      '1.1.14 19Uhr'     => '01.01.2014',
      '1.01.2014 19Uhr'  => '01.01.2014',
      '01.01.2014 19Uhr' => '01.01.2014',
      '1.1.2014 1900'    => '01.01.2014',
      '1.1.2014 19:00'   => '01.01.2014',

      '1979-05-27'       => '27.05.1979',

      '5/27/1979'        => '27.05.1979',
      '7 days from now'  => (Date.today + 7.days).to_s,
      'in seven days'    => (Date.today + 7.days).to_s,
      'in 7 days'        => (Date.today + 7.days).to_s,
      '3 jan 2000'       => '03.01.2000',
      '17 april 15'      => '17.04.2015',
      '5th may 2017'     => '05.05.2017',
      'may 27th'         => get_expected_date_with_year('27.05.'),
      '22nd of june'     => get_expected_date_with_year('22.06.'),
      '22nd of december' => get_expected_date_with_year('22.12.'),

      '29.02.2012'       => '29.02.2012',
      '29.02.2013'       => nil,
      '32.02.2013'       => nil,
      '12.13.2013'       => nil,
      '28.12.20135'      => '28.12.2013',

      '1.8.'             => get_expected_date_with_year('01.08.'),
      '01.08.'           => get_expected_date_with_year('01.08.'),
      '1.08.'            => get_expected_date_with_year('01.08.'),
      '01.8.'            => get_expected_date_with_year('01.08.'),
      '01.8'             => get_expected_date_with_year('01.08.'),
      '1.12.'            => get_expected_date_with_year('01.12.'),
      '1.12'             => get_expected_date_with_year('01.12.'),
      '01.12'            => get_expected_date_with_year('01.12.'),
      '01.12.'           => get_expected_date_with_year('01.12.'),
      '1.1.'             => get_expected_date_with_year('01.01.'),
      '1. Mai'           => get_expected_date_with_year('01.05.'),
      '1. Mai 2017'      => '01.05.2017',
      '1. Mai 17'        => '01.05.2017',
      '1. Mai 2013'      => '01.05.2013',
      'Erster Januar'    => get_expected_date_with_year('01.01.'),
      'Zweiter Januar'   => get_expected_date_with_year('02.01.'),
      'Dritter Januar'   => get_expected_date_with_year('03.01.'),
      'Vierter Januar'   => get_expected_date_with_year('04.01.'),
      'Erster Februar'   => get_expected_date_with_year('01.02.'),
      'Vierter Februar'  => get_expected_date_with_year('04.02.'),
      'Erster März'      => get_expected_date_with_year('01.03.'),
      'Zweiter März'     => get_expected_date_with_year('02.03.'),
      'Dritter März'     => get_expected_date_with_year('03.03.'),
      'Vierter März'     => get_expected_date_with_year('04.03.'),
      'Vierter April'    => get_expected_date_with_year('04.04.'),
      'Vierter Mai'      => get_expected_date_with_year('04.05.'),
      'Vierter Juni'     => get_expected_date_with_year('04.06.'),
      'Vierter Juli'     => get_expected_date_with_year('04.07.'),
      'Vierter August'   => get_expected_date_with_year('04.08.'),
      'Vierter September'=> get_expected_date_with_year('04.09.'),
      'Vierter Oktober'  => get_expected_date_with_year('04.10.'),
      'Vierter November' => get_expected_date_with_year('04.11.'),
      'Vierter Dezember' => get_expected_date_with_year('04.12.'),

  }).each do |current_date_string, expected_date_string|

    test "extract date: #{current_date_string} --> #{expected_date_string}" do
      expected_date = expected_date_string
      expected_date = expected_date_string.to_date unless expected_date.nil?

      assert_equal(expected_date, @date_extractor.extract_date("#{current_date_string} tolles Event www.example.com #event"))
      assert_equal(expected_date, @date_extractor.extract_date("tolles Event #{current_date_string} www.example.com#event"))
      assert_equal(expected_date, @date_extractor.extract_date("tolles Event www.example.com #event #{current_date_string}"))
    end

  end

end