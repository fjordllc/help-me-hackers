class CreateEditors < ActiveRecord::Migration
  def self.up
    create_table :editors do |t|
      t.string :name
    end

    add_index :editors, :name, :unique => true

    Editor.create!(:id => 1, :name => 'emacs')
    Editor.create!(:id => 2, :name => 'vi')
    Editor.create!(:id => 3, :name => 'vim')
    Editor.create!(:id => 4, :name => 'notepad')
    Editor.create!(:id => 5, :name => 'eclipse')
    Editor.create!(:id => 6, :name => 'visual-studio')
    Editor.create!(:id => 7, :name => 'netbeans')
    Editor.create!(:id => 8, :name => 'hidemaru')
    Editor.create!(:id => 9, :name => 'peggy')
    Editor.create!(:id => 10, :name => 'jedit-x')
    Editor.create!(:id => 11, :name => 'sakura-editor')
    Editor.create!(:id => 12, :name => 'emeditor')
    Editor.create!(:id => 13, :name => 'ed')
    Editor.create!(:id => 14, :name => 'nano')
    Editor.create!(:id => 15, :name => 'dreamweaver')
    Editor.create!(:id => 16, :name => 'xcode')
    Editor.create!(:id => 17, :name => 'textmate')
    Editor.create!(:id => 18, :name => 'mi')
    Editor.create!(:id => 19, :name => 'smultron')
  end

  def self.down
    drop_table :editors
  end
end
