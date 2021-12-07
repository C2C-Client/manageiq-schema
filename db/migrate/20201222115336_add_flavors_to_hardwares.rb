class AddFlavorsToHardwares < ActiveRecord::Migration[5.0]
  def change
    add_column :hardwares, :flavors, :text, :array => true, :default => []
  end
end
