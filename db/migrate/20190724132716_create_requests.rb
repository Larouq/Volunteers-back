class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.string :title
      t.text :description
      t.float :lat
      t.float :lng
      t.string :address
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
