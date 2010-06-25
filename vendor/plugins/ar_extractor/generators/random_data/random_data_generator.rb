class RandomDataGenerator < Rails::Generator::NamedBase
  def initialize(runtime_args, runtime_options = {})
    runtime_args = ["ar"]
    super
  end
  
  def manifest
    require "find"
    
    model_files = []
    Find::find("#{RAILS_ROOT}/app/models") { |model_file| model_files << model_file unless FileTest::directory?(model_file) }
    
    klasses = []
    inherited_klasses = []
    model_files.each do |model_file|
      open(model_file) do |file|
        while line = file.gets
          case line
          when /^class/
            table = line.split(/ /)
            base_class = table[3].chomp
            a = [model_file, table[1], base_class, false]
            base_class == "ActiveRecord::Base" ? klasses << a : inherited_klasses << a
          when /establish_connection/
            base_class == "ActiveRecord::Base" ? klasses[-1][3] = true : inherited_klasses[-1][3] = true
          end
        end
      end
    end

    delete_klasses = []
    delete_inherited_klasses = []
    inherited_klasses.each do |inherited_klass|
      klass = klasses.detect { |k| k[1] == inherited_klass[2] }
      if klass
        delete_klasses << klass
        delete_inherited_klasses << inherited_klass if klass[3]
      end
    end
    
    delete_klasses.uniq!
    klasses.reject! { |klass| klass[3] == true }
    models = klasses - delete_klasses + inherited_klasses - delete_inherited_klasses
    models.map! { |model| model[1] }
    

    sources = []
    exclude_model = []
    
    models.each do |model|
      source = "#{model}.populate 20 do |column|\n"
      begin
        columns = model.constantize.columns
      rescue
        exclude_model << model
        next
      end
      columns.each do |column|
        case column.type
        when :float
          value = "0.1"
        when :integer
          case column.name
          when /_id/
            value = "1..20"
          when /year/
            value = "1900..Time.now.year"
          else
            value = "1..10000"
          end
        when :string
          case column.name
          when "name"
            value = "Faker::Name.name"
          else
            value = "Populator.words(1..5).titleize"
          end
        when :text
          value = "Populator.sentences(2..10).titleize"
        when :date, :datetime
          value = "2.years.ago..Time.now"
        when :boolean
          value = "false"
        else
          value = "This column type is not supported. Write your own code."
        end
        
        unless column.name == "id" || column.name == "created_at" || column.name == "updated_at"
          source += "      column.#{column.name} = #{value}\n"
        end
      end
      sources << source
    end

    exclude_model.each { |e|  models.delete(e)  }
    record do |m|
      m.template "population.rake", "lib/tasks/population.rake", :assigns => {:sources => sources, :models => models}
    end
  end
end