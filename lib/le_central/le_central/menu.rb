require './lib/le_central/le_central/menu_item'
require './lib/le_central/le_central/records'

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
        @all_items ||= Records.menu_items_table.all
      end

      def meals
        all_items.map { |i| i[:meal] }.uniq.sort
      end

      def courses
        all_items.map { |i| i[:course] }.uniq.sort
      end

      def flatten(params)
        create(params["meal"])
      end

      def create(menu_item)
        return if menu_item.empty?
        Records.database[:menu_items].insert(
            :active       => 1,
            :meal         => menu_item["meal"],
            :course       => menu_item["course"],
            :meal_order   => menu_item["meal_order"].to_i,
            :name         => menu_item["name"],
            :description  => menu_item["description"],
            :price        => menu_item["price"],
            :created_at   => DateTime.now,
            :updated_at   => DateTime.now
          )
        reset
      end

      def update(params)
        params.each do |key, mi|
          Records.database[:menu_items].where(:id => key.to_i).update(
            :active       => mi["active"].to_i,
            :meal         => mi["meal"],
            :course       => mi["course"],
            :meal_order   => mi["meal_order"].to_i,
            :name         => mi["name"],
            :description  => mi["description"],
            :price        => mi["price"],
            :updated_at   => DateTime.now
            )
          reset
        end
      end

      def reset
        @all_items = nil
      end

      def delete(id)
        Records.database[:menu_items].where(:id => id).delete
        reset
      end

    end
  end
end
