require "sinatra/base"
require "erb"
require "itunes"


module Itunes
  class Server < Sinatra::Base
    dir = File.dirname(File.expand_path(__FILE__))

    set :views, "#{dir}/server/views"
    set :public, "#{dir}/server/public"

    configure do
      Itunes.load(File.expand_path('~/') + '/Music/iTunes/iTunes Music Library.xml')
    end


    helpers do
    end


    get('/') do
      @tracks = Itunes.find(:all)
      erb :index
    end


    get('/track/:id') do
      track = Itunes.find(params[:id])
      send_file track.location, :type => File.extname(track.location)[1..-1]
    end
  end
end
