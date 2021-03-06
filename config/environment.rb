# Load the rails application
require File.expand_path('../application', __FILE__)

# Load the app's custom environment variables here, before environments/*.rb
app_env_vars = File.join(Rails.root, 'config', 'initializers', 'app_env_vars.rb')
load(app_env_vars) if File.exists?(app_env_vars)

# Initialize the rails application
OpenCantine3::Application.initialize!

Date::DATE_FORMATS.merge!(
  :my_format_1 => '%l %p, %b %d, %Y',
  :my_format_2  => '%l:%M %p, %B %d, %Y',

  :default => '%d.%m.%Y',
  :date_time12  => "%m/%d/%Y %I:%M%p",
  :date_time24  => "%d.%m.%Y %H:%M",
  :fr => '%d.%m.%Y',
  :en => '%Y-%m-%d'
)

Time::DATE_FORMATS.merge!(
  :fr => '%d.%m.%Y %H:%M',
  :short => '%d/%m/%Y'

)


