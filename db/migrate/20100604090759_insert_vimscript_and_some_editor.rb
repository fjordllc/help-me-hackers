class InsertVimscriptAndSomeEditor < ActiveRecord::Migration
  def self.up
    # language
    execute "INSERT INTO languages (id, name, kind) VALUES (43, 'vimscript', 'program')"

    # editor
    execute "INSERT INTO editors (id, name) VALUES (20, 'codeditor')"
    execute "INSERT INTO editors (id, name) VALUES (21, 'fraise')"
    execute "INSERT INTO editors (id, name) VALUES (22, 'xyzzy')"
    execute "INSERT INTO editors (id, name) VALUES (23, 'terapad')"
    execute "INSERT INTO editors (id, name) VALUES (24, 'notepadxx')"
    execute "INSERT INTO editors (id, name) VALUES (25, 'noeditor')"
  end

  def self.down
    Language.find_by_name('vimscript').destroy

    Editor.find_by_name('codeditor').destroy
    Editor.find_by_name('fraise').destroy
    Editor.find_by_name('xyzzy').destroy
    Editor.find_by_name('terapad').destroy
    Editor.find_by_name('notepadxx').destroy
    Editor.find_by_name('noeditor').destroy
  end
end
