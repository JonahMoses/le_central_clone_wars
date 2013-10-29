require 'erb'
require 'pony'

module LeCentral
  class Reservation
    attr_reader :res_name, :res_phone, :res_time, :res_guests

    def initialize(reservation)
      @res_name = reservation[:name]
      @res_phone = reservation[:phone]
      @res_time = reservation[:time]
      @res_guests = reservation[:guests]
    end

    def send_email
      Pony.mail({
        :to => 'kevin.m.powell04@gmail.com',
        :subject => "Reservation Request",
        :body => "Name: #{@res_name}, Email: #{@res_phone},\n Subject: #{@res_time},\n Message: #{@res_guests}",
        :via => :smtp,
        :via_options => {
          :address              => 'smtp.gmail.com',
          :port                 => '587',
          :enable_starttls_auto => true,
          :user_name            => 'kevin.m.powell04',
          :password             => '118Kevin!@#',
          :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
          :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
        }
      })
    end

  end
end
