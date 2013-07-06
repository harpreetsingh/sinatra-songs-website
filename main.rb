require 'sinatra'
require 'slim'
require 'sass'
require './song'
require 'sinatra/flash'

configure do
  enable :sessions
  set :username, 'amitabh'
  set :password, 'amit123'
end

before do 
  set_title
end

helpers do
  def current?(path='/')
    (request.path==path || request.path==path + '/') ? "current" : nil
  end

  def set_title 
    @title ||= "Amitabh Bachchan Songs"
  end
end

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

get '/login' do
  slim :login
end

post '/login' do
  if params[:username] == settings.username && params[:password] == settings.password
    session[:admin] = true
    redirect to('/songs')
  else
    slim :login
  end
end

get '/logout' do
  session.clear
  redirect to('/login')
end

not_found do
  slim :not_found
end

