class AddcolumnToAttacments < ActiveRecord::Migration
  def change
  	add_column :attachments, :file, :string
  end
end
