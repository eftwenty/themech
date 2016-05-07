class DropPrimaryColumnFromEmails < ActiveRecord::Migration
  def change
    remove_column :emails, :primary
  end
end
