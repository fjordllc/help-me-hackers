class RenameHacksToComments < ActiveRecord::Migration
  def self.up
    rename_table :hacks, :comments

    execute "UPDATE taggings SET taggable_type = 'Hack' WHERE taggable_type = 'Comment'"
    execute "UPDATE votes SET voteable_type = 'Hack' WHERE voteable_type = 'Comment'"
  end

  def self.down
    rename_table :comments, :hacks

    execute "UPDATE taggings SET taggable_type = 'Comment' WHERE taggable_type = 'Hack'"
    execute "UPDATE votes SET voteable_type = 'Comment' WHERE voteable_type = 'Hack'"
  end
end
