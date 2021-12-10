#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "barbershop.db"}

class Client < ActiveRecord::Base 
	validates :name, presence: true, length: {minimum: 3}
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true
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
	@c = Client.new
	erb :visit
end
 
post '/visit' do 
	
	@c = Client.new params[:client]
	if @c.save 
		erb "<h2>Записались</h2>"	
	else
		@error = @c.errors.full_messages.first
		erb :visit
	end
end

get '/barber/:id' do
	@barber = Barber.find(params[:id])
	erb :barber
end


# <div class="form-group">
#     <label class="form-label">Ваш парикмахер:</label>
#     <select name="barber"class="form-control" aria-label="Default select example">
#         <% @barbers.each do |item| %>
#             <option <%= @barber == item['name']? 'selected': '' %>><%= item['name'] %></option>
#         <% end %>
