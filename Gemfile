source 'http://rubygems.org'

group :test do
  gem 'ffaker'
end

if RUBY_VERSION < "1.9"
  gem "ruby-debug"
elsif RUBY_VERSION < '2.0'
  gem "ruby-debug19"
else
  gem 'byebug'
end

gemspec
