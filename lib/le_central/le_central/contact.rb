require 'erb'
require 'pony'

module LeCentral
  class Contact
    attr_reader :name, :email, :subject, :message

    def initialize(form)
      @name    = form[:name]
      @email   = form[:email]
      @subject = form[:subject]
      @message = form[:message]
    end

    def send_email
      Pony.mail({
        :to => 'kevin.m.powell04@gmail.com',
        :subject => "Contact Email From Website",
        :body => "Name: #{@name}, Email: #{@email},\n Subject: #{@subject},\n Message: #{@message}",
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
