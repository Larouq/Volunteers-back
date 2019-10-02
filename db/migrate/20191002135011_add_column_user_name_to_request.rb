class AddColumnUserNameToRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :user_name, :string
  end
end
