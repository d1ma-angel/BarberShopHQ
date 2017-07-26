#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

before do
        @barbers = Barber.order "created_at DESC"
end

get '/' do
    erb :index
end

get '/visit' do
    erb :visit
end

post '/visit' do
    @username = params[:username]
    @phone = params[:phone]
    @datetime = params[:datetime]
    @barber = params[:barber]
    @color = params[:color]

    hh = {  :username => 'Введите имя',
            :phone => 'Введите телефон',
            :datetime => 'Введите дату и время' }

    @error = hh.select {|key,_| params[key] == ""}.values.join(", ")

    if @error != ''
        return erb :visit
    end

    user = Client.new do |u|
      u.name = @username
      u.phone = @phone
      u.datestamp = @datetime
      u.barber = @barber
      u.color = @color
    end
    user.save

    erb "<h2>Спасибо, вы записались!</h2>"
end

get '/contacts' do
    erb :contacts
end