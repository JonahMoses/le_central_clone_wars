ENV['RACK_ENV'] = 'test'
gem 'minitest'

require 'minitest/autorun'
require 'minitest/pride'
require './lib/le_central/le_central/records'
require 'rack/test'

class RecordsTest < Minitest::Test
  include Rack::Test::Methods

  def setup
    @records = LeCentral::Records
  end

  def test_database_exists
    assert @records.database
  end

  def test_it_creates_menu_items_table
    @records.menu_items_table.insert(
      :active => 1,
      :meal => "Dinner",
      :course => "Appetizer",
      :name => "Frog Legz",
      :description => "Cooked in lots and lots of butter.",
      :price => "9",
      :created_at => DateTime.now
      )
    assert_equal "9", @records.menu_items_table.where(:name => "Frog Legz").get(:price)
  end

  def teardown
    @records.menu_items_table.where(:name => "Frog Legz").delete
  end
end
