require_migration

describe AddProjectNameToExtManagementSystem do
  migration_context :up do
    let(:ext_management_system_stub) { migration_stub(:ExtManagementSystem) }

    it 'sets ExtManagementSystem.project_name to project_name by default' do
      ems = ext_management_system_stub.create!

      migrate

      ems.reload
      expect(ems.project_name).to eq("project_name")
    end

  end
end