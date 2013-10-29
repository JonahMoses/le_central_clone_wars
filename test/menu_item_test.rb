ENV['RACK_ENV'] = 'test'
gem 'minitest'

require 'minitest/autorun'
require 'minitest/pride'
require './lib/le_central/le_central/menu_item'
require 'rack/test'

class MenuItemTest < Minitest::Test
  include Rack::Test::Methods

  def test_it_creates_menu_items
    test_item = {
      :active       => 1,
      :meal         => "Dinner",
      :course       => "Appetizer",
      :menu_order   => 10,
      :name         => "Frog Legz",
      :description  => "Cooked in lots and lots of butter.",
      :price        => "9",
      :created_at   => DateTime.now,
      :updated_at    => DateTime.now
      }
    frog_legz = LeCentral::MenuItem.new(test_item)
    assert_equal "9", frog_legz.price
  end
end
