# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.4.1"

gem "aws-sdk-s3", "~> 1.62"
gem "coffee-rails", "~> 4.2"
gem "haml-rails"
gem "jbuilder", "~> 2.5"
gem "pg"
gem "puma"
gem "rails", "~> 5.2.0.rc1"
gem "sass-rails", "~> 5.0"
gem "shrine"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
# gem 'redis', '~> 4.0'
gem "bootsnap", ">= 1.1.0", require: false
gem "rubocop"
gem "simple_calendar", "~> 2.0"
gem "telegram-bot", github: "telegram-bot-rb/telegram-bot", branch: "master"
gem "whenever", require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "web-console", ">= 3.3.0"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "dotenv-rails"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", "~> 2.15"
  gem "selenium-webdriver"
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem "chromedriver-helper"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
