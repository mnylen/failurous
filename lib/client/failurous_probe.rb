# Based on exception_notification
#    http://github.com/rails/exception_notification
#    Copyright (c) 2005 Jamis Buck, released under the MIT license

require 'action_dispatch'

class FailurousProbe
  
  class << self
    def default_options
      {}
    end
  end
      
  def self.default_ignore_exceptions
    [].tap do |exceptions|
      exceptions << ::ActiveRecord::RecordNotFound if defined?(::ActiveRecord::RecordNotFound)
      exceptions << ::AbstractController::ActionNotFound if defined?(::AbstractController::ActionNotFound)
      exceptions << ::ActionController::RoutingError if defined?(::ActionController::RoutingError)      
    end
  end

  def initialize(app, options = {})
    @app, @options = app, options
  end

  def call(env)
    @app.call(env)
  rescue Exception => exception
    options = (env['failurous.options'] ||= {})
    options.reverse_merge!(@options)
    @options[:ignore_exceptions] ||= self.class.default_ignore_exceptions

    unless Array.wrap(options[:ignore_exceptions]).include?(exception.class)
      send_exception_notification(env, exception)
    end

    raise exception
  end
  
  private
  
  def send_exception_notification(env, exception)
    @env        = env
    @exception  = exception
    @options    = (env['failurous.options'] || {}).reverse_merge(self.class.default_options)
    @kontroller = env['action_controller.instance'] || MissingController.new
    @request    = ActionDispatch::Request.new(env)
    @backtrace  = clean_backtrace(exception)
    @sections   = @options[:sections]
    data        = env['failurous.exception_data'] || {}
    
    p "failurous would now send the exception."
    
  end  
  
  def clean_backtrace(exception)
    Rails.respond_to?(:backtrace_cleaner) ?
      Rails.backtrace_cleaner.send(:filter, exception.backtrace) :
      exception.backtrace
  end
  
end

