ActionController::Routing::Routes.draw do |map|
  map.problems_by_category 'problems/category/:category',
    :controller => 'problems', :action => 'index'
  map.problems_by_tag 'problems/tag/:tag',
    :controller => 'problems', :action => 'index'
  map.users_by_language 'users/language/:language',
    :controller => 'users', :action => 'index'

  map.resources :votes
  map.resources :hacks
  map.resources :problems,
    :collection => {:wanted => :get, :unsolved => :get, :tweet => :post}
  map.dashboard 'dashboard', :controller => 'accounts', :action => 'show'
  map.resource :account, :only => [:show, :edit, :update, :destroy]
  map.resource :user_session, :only => [:new, :create, :destroy]

  map.root :controller => 'top'
  map.root_for_yahoo 'index.html', :controller => 'top'

  map.about 'about', :controller => 'about', :action => 'index'
  map.with_options :controller => 'about',
                   :name_prefix => 'about_',
                   :path_prefix => 'about' do |page|
    page.category 'category', :action => 'category'
    page.license  'license',  :action => 'license'
    page.markdown 'markdown', :action => 'markdown'
    page.terms    'terms',    :action => 'terms'
    page.hint     'hint',     :action => 'hint'
  end

  map.with_options :controller => 'users' do |page|
    page.signup 'signup',  :action => 'signup'
    page.users 'users',  :action => 'index'
    page.user  ':login', :action => 'show'
  end
end
