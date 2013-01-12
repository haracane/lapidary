require "logger"
require "erb"
require "lapidary/command/build"

# RubyGem project support library
module Lapidary
  TEMPLATES_DIR = File.expand_path(File.join(File.dirname(__FILE__), "lapidary", "templates"))
  
  # Converter method from snake case string like 'foo_bar_baz' to camel case string like 'FooBarBaz'
  # @param str [String] Snake case string like 'foo_bar_baz'
  # @return [String] Camel case string like 'FooBarBaz'
  def self.to_camel_case(str)
    return str.split('_').map{|word| word.capitalize}.join
  end
  
  # Reader method for the logger of Lapidary
  # @return [Logger] Logger object
  def self.logger
    if @logger.nil?
      @logger = (rails_logger || default_logger)
      @logger.formatter = proc { |severity, datetime, progname, msg|
        datetime.strftime("[%Y-%m-%d %H:%M:%S](#{severity}) #{msg}\n")
      }
    end
    return @logger
  end

  # Reader method for the rails logger of Lapidary
  # @return [Logger] Logger object
  def self.rails_logger
    (defined?(Rails) && Rails.respond_to?(:logger) && Rails.logger) ||
    (defined?(RAILS_DEFAULT_LOGGER) && RAILS_DEFAULT_LOGGER.respond_to?(:debug) && RAILS_DEFAULT_LOGGER)
  end

  # Reader method for the default logger of Lapidary
  # @return [Logger] Logger object
  def self.default_logger
    l = Logger.new(STDERR)
    l.level = Logger::INFO
    l
  end

  # Writer method for the logger of Lapidary
  # @param logger [Logger]
  def self.logger=(logger)
    @logger = logger
  end
end
