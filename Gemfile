source 'https://rubygems.org'
ruby '2.1.7'

gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'rails', '4.1.1'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'bootstrap_form'
gem 'bcrypt', '~> 3.1.7'
gem 'fabrication'
gem 'faker'
gem 'figaro'
gem 'redis'
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', :require => nil
gem 'unicorn'
gem 'sentry-raven'
gem 'paratrooper'
gem 'carrierwave'
gem 'mini_magick'
gem 'fog'
gem 'stripe'
gem 'stripe_event'
gem 'draper'

group :development do
  gem 'sqlite3'
  gem 'pry'
  gem 'pry-nav'
  gem 'thin'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'zeus'
  gem 'spring'
end

group :test do
  # gem 'database_cleaner', '1.2.0' (from gotealeaf template, buggy)
  gem 'shoulda-matchers', require: false
  gem 'capybara'
  gem 'launchy'
  gem 'capybara-email'
  gem 'vcr'
  gem 'webmock'
  gem 'selenium-webdriver', '>= 2.45'
  gem 'database_cleaner'
end

group :production, :staging do
  gem 'pg'
  gem 'rails_12factor'
end

