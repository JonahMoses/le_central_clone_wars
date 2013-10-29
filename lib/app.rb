require 'sinatra/base'
require './lib/le_central/le_central/contact'

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
      meal_items_hash =
        {"Les Soupes" => [{
          :id => 1,
          :meal => "Dinner",
          :course => "Les Soupes",
          :name => "Soupe De Jour",
          :description => "Cup or Bowl",
          :price => "$2 / $3",
          :active => 1},
          {:id => 2,
          :meal => "Dinner",
          :course => "Les Soupes",
          :name => "Soupe a l'Oignon",
          :description => "Cup or Bowl",
          :price => "$3 / $4",
          :active => 1
          }],
        "Les Moules En Frites" => [{
          :id => 1,
          :meal => "Dinner",
          :course => "Les Moules En Frites",
          :name => "Les Moules En Frites",
          :description => "All mussels are steamed with white",
          :price => "$11.95",
          :active => 1
          }]
        }
      # Menu.menu_items_group_by(meal)
      erb :menu, locals: {meal: meal_items_hash}
    end

    post '/contact' do
      Contact.new(params[:contact]).email
    end

  end
end



