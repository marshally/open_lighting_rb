require 'bundler'
Bundler.setup

if RUBY_VERSION.to_f == 1.9
  require 'simplecov'
  SimpleCov.start do
    add_filter "vendor"
  end
end

require "open_lighting"
