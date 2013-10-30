module LeCentral
  class MenuItem
    attr_reader :menu_item_hash, :id, :active, :meal, :course, :meal_order, :name, :description, :price, :created_at, :updated_at

    def initialize(menu_item_hash)
      @menu_item_hash = menu_item_hash
      build_item
    end

    def build_item
      @id          = menu_item_hash[:id]
      @active      = menu_item_hash[:active]
      @meal        = menu_item_hash[:meal]
      @course      = menu_item_hash[:course]
      @meal_order  = menu_item_hash[:meal_order]
      @name        = menu_item_hash[:name]
      @description = menu_item_hash[:description]
      @price       = menu_item_hash[:price]
      @created_at  = menu_item_hash[:created_at]
      @updated_at  = menu_item_hash[:updated_at]
    end

  end
end
