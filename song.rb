require 'dm-core'
require 'dm-migrations'


configure :development do
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
end

configure :production do
  DataMapper.setup(:default, ENV['DATABASE_URL'])
end

class Song
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :lyrics, Text
  property :length, Integer
  property :released_on, Date
  property :likes, Integer, :default => 0

  def released_on=date
    super Date.strptime(date, '%m/%d/%Y')
  end

end

DataMapper.finalize

get '/songs' do
  @songs = Song.all
  slim :songs
end

post '/songs' do
  song = Song.create(params[:song])
  flash[:notice] = "Song successfully added" if song
  redirect to("/songs/#{song.id}")
end

get '/songs/new' do
  halt(401, 'Not authorized') unless session[:admin]
  @song = Song.new
  slim :new_song
end

get '/songs/:id' do
  @song = Song.get(params[:id])
  slim :show_song
end

get '/songs/:id/edit' do
  @song = Song.get(params[:id])
  slim :edit_song
end

put '/songs/:id' do
  song = Song.get(params[:id])
  if song.update(params[:song])
    flash[:notice] = "Song successfully updated"
  end
  redirect to("/songs/#{song.id}")
end

delete '/songs/:id' do
  if Song.get(params[:id]).destroy
    flash[:notice] = "Song deleted"
  end
  redirect to("/songs")
end

post '/songs/:id/like' do
  @song = Song.get(params[:id])
  @song.likes = @song.likes.next
  @song.save
  redirect to"/songs/#{@song.id}" unless request.xhr?
  slim :like, :layout => false
end
