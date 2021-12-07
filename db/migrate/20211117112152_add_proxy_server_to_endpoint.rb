class AddProxyServerToEndpoint < ActiveRecord::Migration[5.0]
  def change
    add_column :endpoints, :proxy_server, :text
  end
end
