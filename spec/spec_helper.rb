if RUBY_VERSION <= '1.8.7'
else
  require "simplecov"
  require "simplecov-rcov"
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.start
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require "rspec"
require "lapidary"
require "tempfile"

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  
end

module Lapidary
  LAPIDARY_HOME = File.expand_path(File.dirname(__FILE__) + "/..")
  BIN_DIR = "#{LAPIDARY_HOME}/bin"
  LIB_DIR = "#{LAPIDARY_HOME}/lib"
  RUBY_CMD = "ruby -I #{LIB_DIR}"
  REDIRECT = {}
end

Lapidary.logger = Logger.new(STDERR)
if File.exist?('/tmp/lapidary.debug') then
  Lapidary.logger.level = Logger::DEBUG
  Lapidary::REDIRECT[:stdout] = nil
  Lapidary::REDIRECT[:stderr] = nil
else
  Lapidary.logger.level = Logger::ERROR
  Lapidary::REDIRECT[:stdout] = "> /dev/null"
  Lapidary::REDIRECT[:stderr] = "2> /dev/null"
end
