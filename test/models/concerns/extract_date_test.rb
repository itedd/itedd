require 'test_helper'

class ExtractDateTest < ActiveSupport::TestCase

  setup do
    object_class = Class.new
    object_class.send(:include, ExtractDate)
    @date_extractor = object_class.new
  end

  test 'should extract date' do
    assert_equal('1.1.2014', @date_extractor.extract('1.1.2014 tolles Event www.example.com #event')         )
    assert_equal('1.1.2014', @date_extractor.extract('1.1.2014 19Uhr tolles Event www.example.com #event')   )
    assert_equal('1.1.2014', @date_extractor.extract('1.1.14 19Uhr tolles Event www.example.com #event')     )
    assert_equal('1.1.2014', @date_extractor.extract('1.01.2014 19Uhr tolles Event www.example.com #event')  )
    assert_equal('1.1.2014', @date_extractor.extract('01.01.2014 19Uhr tolles Event www.example.com #event') )
    assert_equal('1.1.2014', @date_extractor.extract('1.1.2014 1900 tolles Event www.example.com #event')    )
    assert_equal('1.1.2014', @date_extractor.extract('1.1.2014 19:00 tolles Event www.example.com #event')   )
    assert_equal('1.1.2014', @date_extractor.extract('tolles Event 1.1.2014 www.example.com#event')          )
    assert_equal('1.1.2014', @date_extractor.extract('tolles Event 1.1.2014 19 Uhr www.example.com #event')  )
    assert_equal('1.1.2014', @date_extractor.extract('tolles Event www.example.com #event 1.1.2014')                  )
    assert_equal('1.1.2014', @date_extractor.extract('tolles Event www.example.com #event 1.1.2014 19 Uhr')  )

=begin
    Das Datum muss nicht vollstaendig sein, es wird ggf. um das aktuelle oder das kommende Jahr ergaenzt. ("Naechste Gelegenheit")

    Bei Ausfuehrung am 1.7.2013:
        "1.8. tolles Event www.example.com #event" -> 1.8.2013
    "1.6. tolles Event www.example.com #event" -> 1.6.2014

    Der Monat kann ausgeschrieben, abgekuerzt oder als Zahl enthalten sein.

                                                                          Bei Ausfuehrung am 1.7.2013:
        "1. Mai tolles Event www.example.com #event" -> 1.5.2014

    Der Tag kann ausgeschrieben oder als Zahl enthalten sein

    Bei Ausfuehrung am 1.7.2013:
        "Erster Januar tolles Event www.example.com #event" -> 1.1.2014

=end
  end


end