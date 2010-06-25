require "rails_ext/schema_statements"
require "rails_ext/helper"

# Rails Extention plugin.
module RailsExt
  VERSION = "0.1.0"
end

ActiveRecord::ConnectionAdapters::AbstractAdapter.send :include, RailsExt::SchemaStatements
ActionView::Base.send :include, RailsExt::Helper
