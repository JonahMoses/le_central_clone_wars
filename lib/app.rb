require 'sinatra/base'
require './lib/le_central/le_central/contact'
require './lib/le_central/le_central/reservation'
require './lib/le_central/le_central/menu'
require 'rack-flash'

module LeCentral
  class Controller < Sinatra::Base
    set :method_override, true
    set :root, 'lib/le_central/app'

    enable :sessions
    # use Rack::Session::Cookie
    use Rack::Flash, :accessorize => [:notice, :error]

    def current_user
      session[:admin] == true
    end

    def check_authentication
      unless current_user
        flash[:notice] = "Login Required!"
        redirect '/login'
      end
    end

    get '/login' do
      erb :login
    end

    post "/session" do
      if params['username'] == 'admin' && params['password'] == 'admin'
        login_admin
        redirect "/admin"
      else
        redirect "/"
      end
    end

    def login_admin
      session[:admin] = true
      flash[:notice] = 'You have been logged in.'
    end

    def log_out_admin
      session[:admin] = nil
      flash[:notice] = 'You have been logged out.'
    end

    get "/logout" do
      log_out_admin
      redirect '/'
    end

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
      check_authentication
      erb :admin, locals: {all_items: LeCentral::Menu.all_items}
    end

  end
end



