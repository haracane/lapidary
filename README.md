# Lapidary

Lapidary is a RubyGem project support tool.

Lapidary mainly supports:

* RubyGem management and release based on [Jeweler](https://github.com/technicalpickles/jeweler)
* RubyGem scaffold generation based on [Jeweler](https://github.com/technicalpickles/jeweler)
* Behaviour driven development with [RSpec](https://github.com/dchelimsky/rspec)
* Continuous integration with Jenkins by providing:
  * Source code analysis with [Flog](https://github.com/seattlerb/flog)
  * Code coverage analysis with [RCov](https://github.com/relevance/rcov) ([SimpleCov](https://github.com/colszowka/simplecov))
  * CI report with [CI::Reporter](https://github.com/nicksieger/ci_reporter)

## Supported Ruby versions and implementations
Lapidary should work identically on:

* Ruby 1.9.3
* Ruby 1.9.2
* Ruby 1.8.7

## Install

You can install lapidary by gem.
    gem install lapidary

## Usage

### scaffold new RubyGem project
    $ lapidary mygem

### run rspec
    $ rake spec
This task also measure the code coverage in Ruby 1.9.2/1.9.3.

### measure the code coverage(Ruby 1.8.7)
    $ rake spec:rcov
 
### output CI reports
    $ rake ci:setup:rspec spec

### set gem version
    $ rake version:write MAJOR=0 MINOR=1 PATCH=0

### increment major version
    $ rake version:bump:major

### increment minor version
    $ rake version:bump:minor

### increment patch version
    $ rake version:bump:patch

### build gem
    $ rake build

### create document using YARD
    $ rake yard

### create document using RDoc
    $ rake rdoc

### release gem to RubyGems.org
    $ rake release

### Other

Rake tasks are based on [Jeweler](https://github.com/technicalpickles/jeweler).

You can get more information from [github.com/technicalpickles/jeweler](https://github.com/technicalpickles/jeweler).

## Contributing to Lapidary
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Kenji Hara. See LICENSE.txt for further details.

