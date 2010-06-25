namespace :app do
  desc 'Set database.'
  task :set => %w(db:migrate db:seed)

  desc 'Reset database.'
  task :reset => %w(db:migrate:reset db:seed)
end
