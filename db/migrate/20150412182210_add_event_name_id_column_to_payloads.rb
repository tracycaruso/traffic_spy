class AddEventNameIdColumnToPayloads < ActiveRecord::Migration
  def change
    remove_column :payloads, :event_name, :string
    add_column :payloads, :event_name_id, :integer
  end
end
