source 'https://rubygems.org'
ruby '2.1.1'

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
  gem 'rspec-rails', '2.99'
  gem 'zeus'
  gem 'spring'
end

group :test do
  gem 'database_cleaner', '1.2.0'
  gem 'shoulda-matchers', require: false
  gem 'capybara'
  gem 'launchy'
  gem 'capybara-email'
end

group :production, :staging do
  gem 'pg'
  gem 'rails_12factor'
end

