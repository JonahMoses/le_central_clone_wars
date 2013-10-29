require 'erb'

class Contact
  attr_reader :name, :email, :subject, :message

  def initialize(form)
    @name = form[:name]
    @email = form[:email]
    @subject = form[:subject]
    @message = form[:message]
  end

  def email
    #figure out how pony sends this info via email
  end

end
