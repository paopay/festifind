class AddColumnToFestivals < ActiveRecord::Migration
  def change
  	add_column :festivals, :fest_icon, :string
  end
end
