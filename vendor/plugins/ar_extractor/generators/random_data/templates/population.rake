namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require "populator"
    require "faker"

    [<%= models.join(", ") %>].each(&:delete_all)
    
<% sources.each do |source| -%>
    <%= source -%>
    end

<% end -%>
  end
end
