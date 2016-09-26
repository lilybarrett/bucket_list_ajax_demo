require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'sinatra/flash'
require "json"

enable :sessions

set :bind, '0.0.0.0'  # bind to all interfaces

configure :development, :test do
  require 'pry'
end

configure do
  set :views, 'app/views'
end

Dir[File.join(File.dirname(__FILE__), 'app', '**', '*.rb')].each do |file|
  require file
  also_reload file
end

get '/' do
  redirect "/items"
end

get "/items" do
  @items = Item.all
  erb :items
end

post "/items" do
  if params[:name]
    @item = Item.create({ name: params[:name] })
  end
  redirect "/items"
end

get "/api/v1/items.json" do
  items = Item.all
  items.map(&:to_json).to_json
end

post "/api/v1/items.json" do
  if !(params[:name].strip.empty?)
    item = Item.create({ name: params[:name] })

    status 201
    headers "Location" => "/items/#{item.id}"
  else
    status 400
  end
end
