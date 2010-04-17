module RailsExt
  module SchemaStatements
    # MySQL only.
    #
    # == Options
    # * <tt>:on_update => true</tt> - define ON UPDATE cascade constant.
    # * <tt>:on_delete => true</tt> - define ON DELETE cascade constant.
    def add_foreign_key(from_table, from_column, to_table, options = {:on_update => false, :on_delete => false})
      constraint_name = "fk_#{from_table}_#{to_table}"
      sql = "ALTER TABLE #{from_table} ADD CONSTRAINT" +
        " #{constraint_name} FOREIGN KEY (#{from_column}) REFERENCES #{to_table}(id)"
      sql += " ON UPDATE CASCADE" if options[:on_update]
      sql += " ON DELETE CASCADE" if options[:on_delete]
      execute sql
    end

    # MySQL only.
    def remove_foreign_key(from_table, from_column, to_table)
      constraint_name = "fk_#{from_table}_#{to_table}"
      execute "ALTER TABLE #{from_table} DROP FOREIGN KEY #{constraint_name}"
    end

    # MySQL only.
    def set_auto_increment(table_name, number)
      execute "ALTER TABLE #{quote_table_name(table_name)} AUTO_INCREMENT=#{number}"
    end

    # Load fixtures from dir.
    #
    # == Arguments
    # * <tt>fixture</tt> - Fixture name. ex) entries
    # * <tt>dir</tt> - Fixture file directory path.
    def load_fixture(fixture, dir = "db/seeds")
      require 'active_record/fixtures'
      Fixtures.create_fixtures(dir, fixture)
    end
  end
end
