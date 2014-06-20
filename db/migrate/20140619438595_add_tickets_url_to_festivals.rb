class AddColumnToFestivals < ActiveRecord::Migration
  def change
    add_column :tickets_url, :string
  end
end
