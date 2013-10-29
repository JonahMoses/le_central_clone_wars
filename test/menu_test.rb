ENV['RACK_ENV'] = 'test'
gem 'minitest'

require 'minitest/autorun'
require 'minitest/pride'
require './lib/le_central/le_central/menu'
require './lib/le_central/le_central/records'
require 'rack/test'

class MenuTest < Minitest::Test
  include Rack::Test::Methods

  def setup
    @filet = {
      # :id           => 1,
      :active       => 1,
      :meal         => "Brunch",
      :course       => "Les Poissons",
      :menu_order   => 10,
      :name         => "Filet of Fish",
      :description  => "Fresh Frozen.",
      :price        => "12",
      :created_at   => DateTime.now,
      :updated_at    => DateTime.now
      }
      @steak = {
      :active       => 1,
      :meal         => "Dinner",
      :course       => "Mains",
      :menu_order   => 30,
      :name         => "Steak Pommes Frites",
      :description  => "If it ain't French it's crap!",
      :price        => "29",
      :created_at   => DateTime.now,
      :updated_at    => DateTime.now
      }
      @lobster = {
      :active       => 1,
      :meal         => "Dinner",
      :course       => "Les Poissons",
      :menu_order   => 50,
      :name         => "Lobster",
      :description  => "Bottom Feeders taste magnific!",
      :price        => "Market Price",
      :created_at   => DateTime.now,
      :updated_at    => DateTime.now
      }
      LeCentral::Records.create_menu_items_table
  end

  def test_it_creates_menu_items
    LeCentral::Menu.create(@filet)
    assert_equal "12", LeCentral::Records.menu_items_table.where(:name => "Filet of Fish").get(:price)
  end

  def test_it_can_return_all_items
    LeCentral::Menu.create(@steak)
    LeCentral::Menu.create(@filet)
    assert_equal 2, LeCentral::Menu.all_items.count
  end

  def test_it_can_find_items_by_meal
    LeCentral::Menu.create(@steak)
    LeCentral::Menu.create(@filet)
    assert_equal 1, LeCentral::Menu.find_items_by("Dinner").count
  end

  def test_it_can_group_items_by_course_for_meal
    LeCentral::Menu.create(@steak)
    LeCentral::Menu.create(@lobster)
    LeCentral::Menu.create(@filet)
    assert_equal 2, LeCentral::Menu.group_items_by_course_for("Dinner").keys.count
  end

  def teardown
    LeCentral::Records.menu_items_table.where(:name => "Steak Pommes Frites").delete
    LeCentral::Records.menu_items_table.where(:name => "Filet of Fish").delete
    LeCentral::Records.menu_items_table.where(:name => "Lobster").delete
  end

end
