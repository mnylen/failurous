# Based on exception_notification
#    http://github.com/rails/exception_notification
#    Copyright (c) 2005 Jamis Buck, released under the MIT license

require 'action_dispatch'

module Failurous
  class FailMiddleware
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
      unless FailMiddleware.default_ignore_exceptions.include?(exception.class)
        send_exception_notification(env, exception)
      end

      raise exception
    end
  
    private
  
    def send_exception_notification(env, exception)
      @env        = env
      @exception  = exception
      @controller = env['action_controller.instance'] || MissingController.new
      @request    = ActionDispatch::Request.new(env)
      @backtrace  = clean_backtrace(exception)
    
      notification = FailNotification.new.
        from_exception(exception).
        add_field(:request, :REQUEST_METHOD, @request.method, {:humanize_field_name => false}).
        add_field(:request, :REQUEST_URI, @request.request_uri, {:humanize_field_name => false}).
        add_field(:request, :REMOTE_ADDR, @request.remote_ip, {:humanize_field_name => false}).
        add_field(:request, :HTTP_USER_AGENT, @request.headers["User-Agent"], {:humanize_field_name => false}).
        add_field(:summary, :location, "#{@controller.controller_name}##{@controller.action_name}", {:use_in_checksum => true}).
        add_field(:details, :params, @controller.params, {:use_in_checksum => false})
      
      
      FailNotifier.send_fail(notification)
    end  
  
    def clean_backtrace(exception)
      Rails.respond_to?(:backtrace_cleaner) ?
        Rails.backtrace_cleaner.send(:filter, exception.backtrace) :
        exception.backtrace
    end
  
  end
end