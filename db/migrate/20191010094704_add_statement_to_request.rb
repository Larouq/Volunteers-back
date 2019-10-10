class AddStatementToRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :statement, :integer, :default => 0
  end
end
