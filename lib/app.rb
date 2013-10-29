require 'sinatra/base'
require './lib/le_central/le_central/contact'
require './lib/le_central/le_central/reservation'

module LeCentral
  class Controller < Sinatra::Base
    set :method_override, true
    set :root, 'lib/le_central/app'

    get '/' do
      erb :index
    end

    get '/about' do
      erb :about
    end

    get '/contact' do
      erb :contact
    end

    get '/gallery' do
      erb :gallery
    end

    get '/reservation' do
      erb :reservation
    end

    get '/menu/:meal' do |meal|
      meal_items = Menu.items(meal)
      erb :menu, locals: {meal: meal_items}
    end

    post '/contact' do
      LeCentral::Contact.new(params[:contact]).send_email
      redirect '/'
    end

    post '/reservation' do
      LeCentral::Reservation.new(params[:reservation]).send_email
      redirect '/'
    end

  end
end



