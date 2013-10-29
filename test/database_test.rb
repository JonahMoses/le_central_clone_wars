ENV['RACK_ENV'] = 'test'
gem 'minitest'

require 'minitest/autorun'
require 'minitest/pride'
require './lib/le_central/le_central/database'
require 'rack/test'

class DatabaseTest < Minitest::Test
  include Rack::Test::Methods

  def setup
    @db = LeCentral::Database
  end

  def test_database_exists
    assert @db.database
  end

  def test_it_creates_menu_items_table
    @db.menu_items_table.insert(
      :active => 1,
      :meal => "Dinner",
      :course => "Appetizer",
      :name => "Frog Legz",
      :description => "Cooked in lots and lots of butter.",
      :price => "9",
      :created_at => DateTime.now
      )
    assert_equal "9", @db.menu_items_table.where(:name => "Frog Legz").get(:price)
  end

  def teardown
    @db.menu_items_table.where(:name => "Frog Legz").delete
  end
end
