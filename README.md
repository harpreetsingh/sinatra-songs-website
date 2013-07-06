sinatra-songs-website
=====================

Songs by Amitabh website

Working example of "Jump Start Sinatra" book. Modified Sinatra to Amitabh, well as I like Amitabh more than Sinatra :-)

_Uses sqlite for development database_

go to production steps
----------------------
* Specify gems used
`gem install bundler`

add all gems used in Gemfile

`bundle install --production`

This should create a new file called Gemfile.lock that contains all the gems we are using, as well astheir dependencies. The --without production flag ensures that any gems that were placed in the production group aren’t installed locally.

* Rack-it-up
Create a config.ru file
`require './main.rb'`
`run Sinatra::Application`
