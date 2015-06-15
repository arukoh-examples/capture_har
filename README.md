# capture_har

# Installation

sample here:

```
# @ubuntu

# for ruby
$ sudo add-apt-repository -y ppa:brightbox/ruby-ng
$ sudo apt-get update

$ sudo apt-get install build-essential unzip git xvfb firefox default-jre ruby2.1 ruby2.1-dev
$ sudo gem install bundler --no-ri --no-rdoc

$ git clone https://github.com/samples-of-arukoh/capture_har.git
$ cd capture_har/
$ bundle install --path vendor/bundle

$./setup_browsermob-proxy 
$ bundle exec ruby sample.rb 
```
