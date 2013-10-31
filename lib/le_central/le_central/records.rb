require 'bundler'
Bundler.require
require 'csv'
require 'pry'
require './lib/le_central/le_central/menu.rb'

module LeCentral

  class Records

    def self.database
      if ENV['RACK_ENV'] == 'test'
        @database ||= Sequel.postgres("postgres://jonahmoses@localhost/le_central_test")
      else
        @database ||= Sequel.postgres(ENV["DATABASE_URL"] || :host=>'localhost', :user=>ENV["DB_USER"], :database=>'le_central_development')
      end
    end

    def self.create_menu_items_table
      database.create_table? :menu_items do
        primary_key :id
        Integer     :active
        Text      :meal
        Text      :course
        Integer     :meal_order
        Text      :name
        Text      :description
        Text      :price
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
