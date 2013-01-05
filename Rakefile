# encoding: utf-8

require "rubygems"
require "bundler"
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require "rake"

require "jeweler"
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "lapidary"
  gem.homepage = "http://github.com/haracane/lapidary"
  gem.license = "MIT"
  gem.summary = "Helper for creating RubyGem project"
  gem.description = "Helper for creating RubyGem project"
  gem.email = "haracane@gmail.com"
  gem.authors = ["Kenji Hara"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require "rspec/core"
require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList["spec/**/*_spec.rb"]
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = "spec/**/*_spec.rb"
  spec.rcov = true
end

task :default => :spec

require "rdoc/task"
Rake::RDocTask.new do |rdoc|
  version = File.exist?("VERSION") ? File.read("VERSION") : ""

  rdoc.rdoc_dir = "rdoc"
  rdoc.title = "lapidary #{version}"
  rdoc.rdoc_files.include("README*")
  rdoc.rdoc_files.include("lib/**/*.rb")
end

require "ci/reporter/rake/rspec"     # use this if you're using RSpec

if RUBY_VERSION <= '1.8.7'
  require "rcov"
  RSpec::Core::RakeTask.new("spec:rcov") do |t|
    t.rcov = true
    t.rspec_opts = ["-c"]
    t.rcov_opts = ["-x", "spec"]
  end
else
  RSpec::Core::RakeTask.new("spec:rcov") do |t|
    t.rspec_opts = ["-v"]
  end
end

