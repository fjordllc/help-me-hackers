class InsertHtmlAndCssToLanguages < ActiveRecord::Migration
  def self.up
    Language.create!(:id => 41, :name => 'html', :kind => 'program')
    Language.create!(:id => 42, :name => 'css', :kind => 'program')
  end

  def self.down
    Language.find_by_name('html').destroy
    Language.find_by_name('css').destroy
  end
end
