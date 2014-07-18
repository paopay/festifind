class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.string :comment
    	t.string :festival
    	t.string :user
    	t.timestamps
    end
  end
end
