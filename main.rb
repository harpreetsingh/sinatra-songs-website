require 'sinatra'
require 'slim'
require 'sass'

get('/styles.css') { scss :styles }
get '/' do
  slim :home
end

get '/about' do
  @title = "All about this website"
  slim :about
end

get '/contact' do
  slim :contact
end

not_found do
  slim :not_found
end


