class ChangeMessageTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :request_id
    add_reference :messages, :response, foreign_key: true
  end
end
