def load_fixture(fixture, dir = "db/seeds")
  puts "loading #{fixture} ..."
  require 'active_record/fixtures'
  Fixtures.create_fixtures(dir, fixture)
end

load_fixture :languages
load_fixture :licenses
load_fixture :countries
load_fixture :states
load_fixture :editors

unless ENV['CAP_ENV'] == 'production'
  load_fixture :languages
  load_fixture :licenses
  load_fixture :countries
  load_fixture :states
  load_fixture :users
  load_fixture :tasks
  load_fixture :comments
  load_fixture :tags
  load_fixture :taggings
  load_fixture :projects
end
