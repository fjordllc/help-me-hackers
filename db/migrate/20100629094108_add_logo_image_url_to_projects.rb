class AddLogoImageUrlToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :logo_image_url, :text
  end

  def self.down
    remove_column :projects, :logo_image_url
  end
end
