class AddResourceGroupNameToEndpoint < ActiveRecord::Migration[5.0]
  def change
    add_column :endpoints, :resource_group_name, :text
  end
end
