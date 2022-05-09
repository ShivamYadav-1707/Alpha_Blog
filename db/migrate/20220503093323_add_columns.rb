class AddColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :gender, :string
    add_column :users, :phone, :integer
    add_column :users, :is_admin, :boolean
    add_column :articles, :title, :string
    add_column :articles, :description, :string

  end
end
