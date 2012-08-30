# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
OpenCantine3::Application.initialize!

Date::DATE_FORMATS.merge!(
  :my_format_1 => '%l %p, %b %d, %Y',
  :my_format_2  => '%l:%M %p, %B %d, %Y',

  :default => '%m/%d/%Y',
  :date_time12  => "%m/%d/%Y %I:%M%p",
  :date_time24  => "%m/%d/%Y %H:%M",
  :fr => '%d.%m.%Y',
  :en => '%Y-%m-%d'
)

Time::DATE_FORMATS.merge!(
  :fr => '%d.%m.%Y %H:%M'
)


#CalendarDateSelect.default_options.update(:popup => 'force')
#CalendarDateSelect.format = :finnish
