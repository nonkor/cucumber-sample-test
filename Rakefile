require 'English'

task :test do
  exec 'bundle exec cucumber'
end

task :travis do
  puts 'Grabbing chromedriver...'
  mkdir_p '/tmp/bin'
  system 'cd /tmp/bin &&' \
         'wget http://chromedriver.storage.googleapis.com/2.11/chromedriver_linux64.zip && ' \
         'unzip chromedriver_linux64.zip'

  puts 'Starting to run tests...'
  system 'export PATH=/tmp/bin:$PATH && ' \
         'export DISPLAY=:99.0 && ' \
         'export BROWSER=chrome && ' \
         'bundle exec rake test'
  fail '`rake test` failed!' unless $CHILD_STATUS.exitstatus.zero?
end
