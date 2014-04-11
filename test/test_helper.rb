ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
MiniTest::Reporters.use!

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def self.test_access(name, *allowed, &block)
    allowed.first.each do |action, value|
      value = [value] unless value.is_a? Array
      value.each do |user|
        self.send :test, "#{name} should #{action} for #{user}" do
          sign_in users(user) unless user==:anonymous
          case action
            when :redirect then
              instance_eval &block
              assert_response :redirect, @response.body
            when :deny then
              assert_raise CanCan::AccessDenied do
                instance_eval &block
              end
            when :success then
              instance_eval &block
              assert_response :success, @response.body
            when :error then
              begin
                instance_eval &block
                assert false, 'Error expected'
              rescue Exception=>e
              end
          end
        end
      end
    end
  end
end

class ActionController::TestCase
  include Devise::TestHelpers
end
