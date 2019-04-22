require 'bundler'
Bundler.require
require 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossip: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end
  
  get '/gossips/:id' do 
    erb :gossip_page, locals: {gossip: Gossip.find(params["id"]), id: params["id"]}
  end

  get '/gossips/:id/edit' do
    erb :edit, locals: {id: params["id"]}
  end

  post '/gossips/:id/edit' do
    Gossip.edit(params["id"], params["gossip_new_author"], params["gossip_new_content"])
    redirect '/'
  end

end
