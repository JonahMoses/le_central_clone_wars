ENV['RACK_ENV'] = 'test'
gem 'minitest'

require 'minitest/autorun'
require 'minitest/pride'
require './lib/app'
require 'rack/test'

class ControllerTest < Minitest::Test
  include Rack::Test::Methods

  def app
    LeCentral::Controller
  end

  def test_it_exists
    assert LeCentral::Controller
  end

  # def test_le_central
  #   get '/'
  #   assert (last_response.body =~ /Welcome To Le Central/)
  # end


end
