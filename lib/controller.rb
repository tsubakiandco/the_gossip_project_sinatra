require 'bundler'
Bundler.require
require 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossip: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip #Affiche la page de formulaire de potins.
  end

  post '/gossips/new/' do #Sauvegarde les donnees du formulaire dans un fichier CSV
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end
  
  get '/gossips/:id' do #Affiche la page de chaque gossip en fonction de son ID
    erb :gossip_page, locals: {gossip: Gossip.find(params["id"]), id: params["id"]}
  end
  
  get '/gossips/:id/edit' do  #Affiche la page de nodification du gossip.
    erb :edit, locals: {id: params["id"]}
  end

  post '/gossips/:id/edit' do
    Gossip.edit(params["id"], params["gossip_new_author"], params["gossip_new_content"])
    redirect '/'
  end

end
