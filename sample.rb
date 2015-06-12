require 'rubygems'
require 'headless'
require 'selenium-webdriver'
require 'browsermob/proxy'

# setup headless
options = {}
headless = Headless.new(options)
headless.start
at_exit { headless.destroy }

# setup proxy
browsermob_proxy_bin = File.expand_path('../tmp/browsermob-proxy/bin/browsermob-proxy', __FILE__)
server = BrowserMob::Proxy::Server.new(browsermob_proxy_bin)
server.start
proxy = server.create_proxy
at_exit { proxy.close }

# setup driver
profile = Selenium::WebDriver::Firefox::Profile.new
profile.proxy = proxy.selenium_proxy(:http, :ssl)
driver = Selenium::WebDriver.for(:firefox, profile: profile)
driver.manage.timeouts.implicit_wait = 1
at_exit { driver.close }
wait = Selenium::WebDriver::Wait.new(:timeout => 10)

# prepare
proxy.new_har('sample')

# browsing
driver.get('https://facebook.com')
wait.until { driver.title =~ /Facebook/ }
driver.get('https://twitter.com')
wait.until { driver.title =~ /Twitter/ }
driver.get('http://google.com')
driver.find_element(:class, 'gsfi').send_key('selenium')
driver.find_element(:name, 'btnK').submit
driver.find_element(:xpath, '//*[@id="rso"]/div[2]/li[1]/div/h3/a').click
wait.until { driver.title =~ /Selenium/ }

# dump har
har = proxy.har
har.save_to('tmp/sample.har')
