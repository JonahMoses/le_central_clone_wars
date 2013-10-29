require 'sinatra/base'
require './lib/le_central/le_central/contact'
require './lib/le_central/le_central/menu'

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
      Contact.new(params[:contact]).email
    end

  end
end



