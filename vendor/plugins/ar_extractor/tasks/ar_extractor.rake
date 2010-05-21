namespace :db do
  namespace :fixtures do
    desc "Extract DB to YAML fixtures."
    task :extract => :environment do
      fixtures_dir = db_connection

      tables = {}
      table = []
      open("#{RAILS_ROOT}/db/schema.rb") do |file|
        while line = file.gets
          next if line.blank?
          case line
          when /create_table/
            table = []
            table << line.split(/"/)[1]
            has_id = line.split(/,/).detect { |l| /:id => false/ =~ l }
            table << "id" unless has_id
          when /t\./
            column = line.split(/"/)[1]
            table << column # unless /created_at|updated_at/ =~ column
          when /  end/
            tables[table.shift] = table unless table.blank?
          end
        end
      end

      tables.delete("sessions")

      tables.each do |table_name, columns|
        next if ENV["FIXTURES"] && !ENV["FIXTURES"].split(/,/).include?(table_name)
        order = columns.include?("id") ? " ORDER BY id" : ""
        records = execute_sql(table_name, order)
        next if records.empty?
        write_fixtures(fixtures_dir + table_name, records, columns) { |record, column, i| entry_fixture(column, record[column]) }
      end
    end


    task :convert => :environment do
      desc "Convert data from legacy schema to another."
      CONFIG_FILE = "#{RAILS_ROOT}/config/tables.yml"
      if    ENV["DB"].nil?            then raise ArgumentError, "Set argument DB.\ne.g. rake db:fixtuers:convert DB=foo"
      elsif !File.exist?(CONFIG_FILE) then raise IOError      , "Doesn't exist #{CONFIG_FILE}"
      end

      require "find"
      fixtures_dir = db_connection(ENV["DB"])

      table_list = YAML::load_file(CONFIG_FILE)

      files = []
      Find::find("#{fixtures_dir}") { |path| files << path }
      mod = exist_module?
      include mod if mod

      com_tantosya_conditions = ""
      cum_kanyosaki_conditions = ""

      table_list.each do |before_table, after_tables|
        before_table = before_table.split(/::/)
        model = before_table.map { |table| table.camelize }.join("::").constantize
        conditions = ""
        if exist_module?
          case before_table[-1]
          when "com_tantosya"
            com_tantosya_conditions = "birthday IS NOT NULL AND taisya_date IS NULL"
            conditions = " WHERE #{ com_tantosya_conditions }"
          when "cum_kanyosaki"
            cum_kanyosaki_conditions = "kanyosaki_cd < 990000"
            conditions = " WHERE #{ cum_kanyosaki_conditions }"
          end
        end
        
        records = execute_sql(before_table[-1], "#{ conditions } ORDER BY #{model.primary_key}")
        next if records.empty?

        after_tables.each do |after_table, column_map|
          delete_file = files.detect { |file| %r(/#{after_table}.yml$) =~ file }
          if delete_file
            FileUtils.rm(delete_file)
            files.reject! { |file| file == delete_file }
          end

          write_fixtures(fixtures_dir + after_table, records, model.columns, "a") do |record, column, i|
            next unless column_map[column.name]
            conditional_branch(column.name, before_table[-1], record) if defined?(conditional_branch)
            entry_fixture(column_map[column.name], record[column.name])
          end
        end
      end

      save_records(com_tantosya_conditions, cum_kanyosaki_conditions, ENV["RAILS_ENV"]) if defined?(save_records)
    end
  end
end

private
def db_connection(db = nil)
  ActiveRecord::Base.establish_connection(db)
  fixtures_dir = RAILS_ROOT + "/"
  fixtures_dir += File.exist?(fixtures_dir + "spec") && !exist_module? ? "spec" : "test"
  fixtures_dir += "/fixtures/"
  FileUtils.mkdir_p(fixtures_dir)
  fixtures_dir
end

def execute_sql(table_name, order)
  sql = "SELECT * FROM %s" + order
  ActiveRecord::Base.connection.select_all(sql % table_name)
end

def write_fixtures(file_name, records, columns, mode = "w")
  yaml = "#{file_name}.yml"
  i = 0
  
  if File.exist?(yaml)
    open(yaml) do |file|
      while line = file.gets
        i += 1 if /^data/ =~ line
      end
    end
  end

  open(yaml, mode) do |file|
    records.each do |record|
      rec = ["data#{i += 1}:"]
      columns.each do |column|
        r = yield record, column, i
        rec << r
      end
      file.write rec.compact.join("\n") + "\n" * 2
    end
  end
end

def entry_fixture(column, value)
  if value.nil? || (value == "0" && column =~ /_id$|^type$/)
    nil
  else
    return unless value.class == String
    value.strip!
    value.gsub!(/\t|\?/, "")
    value.gsub!(/\[/, "［")
    value.gsub!(/\]/, "］")
    if value =~ /\n/
      "  #{column}: |\n    " + value.split("\n").join("\n    ")
    else
      "  #{column}: #{value}"
    end
  end
end

def exist_module?
  mod = "FantasistaModule"
  File.exist?("#{RAILS_ROOT}/lib/#{mod.underscore}.rb") ? mod.constantize : false
end

