namespace :app do
  desc "Reset database."
  task :reset => ["db:migrate:reset", "db:seed"] do
    puts "reset!"
  end
end
