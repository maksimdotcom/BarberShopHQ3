#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "barbershop.db"}

class Client < ActiveRecord::Base 
end

class Barber < ActiveRecord::Base 
end

before do 
	@barbers = Barber.all
end

get '/' do
	erb :index
end

get '/visit' do

	erb :visit
end
 
post '/visit' do 
	
	c = Client.new params[:client]
	c.save

end


# <div class="form-group">
#     <label class="form-label">Ваш парикмахер:</label>
#     <select name="barber"class="form-control" aria-label="Default select example">
#         <% @barbers.each do |item| %>
#             <option <%= @barber == item['name']? 'selected': '' %>><%= item['name'] %></option>
#         <% end %>
