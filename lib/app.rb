require 'sinatra/base'

module LeCentral
  class Controller < Sinatra::Base
    # set :method_override, true
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

  end
end



