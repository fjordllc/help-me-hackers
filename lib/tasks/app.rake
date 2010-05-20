namespace :app do
  desc "Set database."
  task :set => ["db:migrate", "db:seed"] do
    puts "set!"
  end

  desc "Reset database."
  task :reset => ["db:migrate:reset", "db:seed"] do
    puts "reset!"
  end
end
