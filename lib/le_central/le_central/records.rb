require 'bundler'
Bundler.require
require 'csv'
require 'pry'
require './lib/le_central/le_central/menu.rb'

module LeCentral

  class Records

    def self.database
      if ENV['RACK_ENV'] == 'test'
        @database ||= Sequel.sqlite('lib/le_central/db/test_database.sqlite3')
      else
        @database ||= Sequel.sqlite('lib/le_central/db/database.sqlite3')
      end
    end

    def self.create_menu_items_table
      database.create_table? :menu_items do
        primary_key :id
        Integer     :active
        String      :meal,        :size => 10
        String      :course,      :size => 30
        Integer     :meal_order
        String      :name,        :size => 50
        String      :description, :size => 200
        String      :price,       :size => 20
        DateTime    :created_at
        DateTime    :updated_at
      end
    end

    def self.menu_items_table
      if database.table_exists?(:menu_items)
        database.from(:menu_items)
      else
        create_menu_items_table
        database.from(:menu_items)
      end
    end

    def self.load_csv_menu
      menu_items_table.delete
      menu_data.each do |row|
        LeCentral::Menu.create({
          :active         => row[:active],
          :meal           => row[:meal],
          :course         => row[:course],
          :meal_order     => row[:meal_order],
          :name           => row[:name],
          :description    => row[:description],
          :price          => row[:price]
          })
      end
    end

    def self.menu_data
      CSV.read("./test/menu_data.csv", headers: true, header_converters: :symbol)
    end


  end
end
