class AddProjectNameToExtManagementSystem < ActiveRecord::Migration[5.0]
  class ExtManagementSystem < ActiveRecord::Base
    self.inheritance_column = :_type_disabled
  end

  def change
    add_column :ext_management_systems, :project_name, :string

    say_with_time('Setting ExtManagementSystem.project_name to project_name') do
      ExtManagementSystem.update_all(:project_name => 'project_name')
    end
  end
end