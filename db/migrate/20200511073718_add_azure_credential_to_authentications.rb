class AddAzureCredentialToAuthentications < ActiveRecord::Migration[5.0]
  def change
    add_column :authentications, :cb_storage_accesskey, :string
    add_column :authentications, :cb_storage_secretkey, :string
  end
end
