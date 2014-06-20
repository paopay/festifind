class AddTicketsUrlToFestivals < ActiveRecord::Migration
  def change
    add_column :festivals, :tickets_url, :string
  end
end
