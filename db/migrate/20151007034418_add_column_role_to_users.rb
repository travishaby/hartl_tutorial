class AddColumnRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: "default"
  end
end
