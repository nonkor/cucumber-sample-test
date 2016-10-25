require 'watir-webdriver'
require 'watirsome'
require 'watir-dom-wait'
require 'rspec/expectations'
require 'rspec/collection_matchers'
require 'require_all'
require 'byebug'
require 'nokogiri'
require_rel 'lib'
require_rel 'pages'

settings = YAML.load(File.open('config/settings.yml'))
Testing.browser = Watir::Browser.new(ENV['BROWSER'] || settings[:browser])
Testing.timeout = settings[:step_timeout]
Testing.clean_report_repository

at_exit { Testing.browser&.close }
