require './lib/le_central/le_central/menu_item'
require './lib/le_central/le_central/records'
require 'pry'

module LeCentral

  class Menu

    class << self

      def group_items_by_course_for(meal)
        find_items_by(meal).group_by { |mi| mi[:course] }
      end

      def find_items_by(meal)
        items = active_items.find_all { |i| i[:meal] == meal }
        items.sort_by { |i| i[:meal_order] }
      end

      def active_items
        all_items.find_all { |i| i[:active] == 1 }
      end

      def all_items
        Records.menu_items_table.all
      end

      def meals
        all_items.map { |i| i[:meal] }.uniq.sort
      end

      def courses
        all_items.map { |i| i[:course] }.uniq.sort
      end

      def create(menu_item)
        return if menu_item[:name].nil?
        menu_item[:created_at] = DateTime.now
        menu_item[:updated_at] = DateTime.now
        Records.database.transaction  do
          Records.database[:menu_items] << menu_item
        end
      end

      def find
      end

      def update(data)
        

      end

    end
  end
end
