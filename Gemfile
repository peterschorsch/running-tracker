source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/peterschorsch/running-tracker.git" }

ruby '2.6.3'

gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'chosen-rails'
gem 'bcrypt'#, '~> 3.1.7' for user passwords
gem 'pry-rails'
gem 'awesome_print'
gem 'paperclip'
gem 'database_cleaner'
gem "simple_calendar", "~> 2.0"
gem "chartkick"
gem 'jquery-datatables-rails'
gem 'auto-session-timeout'
gem 'city-state'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4', '>= 5.2.4.3'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen'
  gem 'bullet'
  gem 'traceroute'
  gem 'rack-mini-profiler'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
