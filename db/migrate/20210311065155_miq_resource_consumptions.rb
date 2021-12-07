class MiqResourceConsumptions < ActiveRecord::Migration[5.0]
  def change
  	create_table "miq_resource_consumptions" do |t|
        t.string   "resource_id"
        t.string   "resource_name"
        t.string   "resource_type"
        t.bigint   "ems_id"
        t.bigint   "user_id"
        t.boolean  "IsCreatedFromCB"
        t.string   "created_by"
  	    t.datetime "created_on"
        t.string   "updated_by"
  	    t.datetime "updated_on"
  	    t.bigint   "miq_task_id"
    end
    add_index :miq_resource_consumptions, :resource_id, :unique => true
  end
end
