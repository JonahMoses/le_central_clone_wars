require 'sinatra/base'
require './lib/le_central/le_central/contact'
<<<<<<< HEAD
require './lib/le_central/le_central/reservation'
=======
require './lib/le_central/le_central/menu'
>>>>>>> 6d509919af03c31f58d75095e1bc2e2c45c8bac2

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
      meal_items = LeCentral::Menu.group_items_by_course_for(meal)
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

    get '/admin' do
      erb :admin, locals: {all_items: LeCentral::Menu.all_items}
    end

  end
end



