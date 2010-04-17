# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{remarkable_rails}
  s.version = "3.1.13"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Carlos Brando", "Jos\303\251 Valim"]
  s.date = %q{2010-02-19}
  s.description = %q{Remarkable Rails: collection of matchers and macros with I18n for Rails}
  s.email = ["eduardobrando@gmail.com", "jose.valim@gmail.com"]
  s.extra_rdoc_files = ["README", "LICENSE", "CHANGELOG"]
  s.files = ["README", "LICENSE", "CHANGELOG", "lib/remarkable_rails", "lib/remarkable_rails/action_controller", "lib/remarkable_rails/action_controller/base.rb", "lib/remarkable_rails/action_controller/macro_stubs.rb", "lib/remarkable_rails/action_controller/matchers", "lib/remarkable_rails/action_controller/matchers/assign_to_matcher.rb", "lib/remarkable_rails/action_controller/matchers/filter_params_matcher.rb", "lib/remarkable_rails/action_controller/matchers/redirect_to_matcher.rb", "lib/remarkable_rails/action_controller/matchers/render_template_matcher.rb", "lib/remarkable_rails/action_controller/matchers/respond_with_matcher.rb", "lib/remarkable_rails/action_controller/matchers/route_matcher.rb", "lib/remarkable_rails/action_controller/matchers/set_cookies_matcher.rb", "lib/remarkable_rails/action_controller/matchers/set_session_matcher.rb", "lib/remarkable_rails/action_controller/matchers/set_the_flash_matcher.rb", "lib/remarkable_rails/action_controller.rb", "lib/remarkable_rails/action_view", "lib/remarkable_rails/action_view/base.rb", "lib/remarkable_rails/action_view.rb", "lib/remarkable_rails/active_orm.rb", "lib/remarkable_rails.rb", "locale/en.yml", "remarkable_rails.gemspec"]
  s.homepage = %q{http://github.com/carlosbrando/remarkable}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{remarkable}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Remarkable Rails: collection of matchers and macros with I18n for Rails}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rspec>, [">= 1.2.0"])
      s.add_runtime_dependency(%q<rspec-rails>, [">= 1.2.0"])
      s.add_runtime_dependency(%q<remarkable>, ["~> 3.1.13"])
      s.add_runtime_dependency(%q<remarkable_activerecord>, ["~> 3.1.13"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.0"])
      s.add_dependency(%q<rspec-rails>, [">= 1.2.0"])
      s.add_dependency(%q<remarkable>, ["~> 3.1.13"])
      s.add_dependency(%q<remarkable_activerecord>, ["~> 3.1.13"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.0"])
    s.add_dependency(%q<rspec-rails>, [">= 1.2.0"])
    s.add_dependency(%q<remarkable>, ["~> 3.1.13"])
    s.add_dependency(%q<remarkable_activerecord>, ["~> 3.1.13"])
  end
end
