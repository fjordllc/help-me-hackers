#!/usr/bin/env ruby

def _run(cmd)
  puts cmd
  `#{cmd}`
end

RAILS_ROOT = File.dirname(__FILE__)

`cd #{RAILS_ROOT}`
_run "sudo rake gems:install"
_run "rake app:reset"
