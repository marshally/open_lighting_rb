require 'bundler'
Bundler.setup

require "open_lighting"

if RUBY_VERSION.to_f == 1.9
  require 'simplecov'
  SimpleCov.start
end
