source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

#gem 'sqlite3'

gem 'pg' 

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
 
  gem 'uglifier'
end

gem 'jquery-rails'

#Domenico D'Egidio
gem 'execjs'
gem 'therubyracer', :platforms=>:ruby
gem 'activemerchant', '~> 1.10.0'



# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test, :development  do
  # Pretty printed test output
  # gem 'turn', :require => false
  gem 'rspec-rails', '~> 2.5'
  
end

group :test do
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'spork', '0.9.0.rc9'
  gem 'database_cleaner'
  gem 'factory_girl' 
  gem 'email_spec' # mi serve a testare il modulo confirmable di devise.   
end

gem 'devise', '~> 1.4.3'

