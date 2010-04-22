def load_fixture(fixture, dir = "db/seeds")
  require 'active_record/fixtures'
  Fixtures.create_fixtures(dir, fixture)
end


if ENV['CAP_ENV'] == 'production'
  load_fixture :languages
  load_fixture :licenses
  load_fixture :categories
  load_fixture :countries
  load_fixture :states
else
  load_fixture :languages
  load_fixture :licenses
  load_fixture :categories
  load_fixture :countries
  load_fixture :states
  load_fixture :users
  load_fixture :problems
  load_fixture :answers
  load_fixture :tags
  load_fixture :taggings
end
