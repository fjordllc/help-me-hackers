ActionController::Routing::Routes.draw do |map|
  map.tasks_by_language 'tasks/language/:language',
    :controller => 'tasks', :action => 'index'
  map.tasks_by_tag 'tasks/tag/:tag',
    :controller => 'tasks', :action => 'index'
  map.users_by_language 'users/language/:language',
    :controller => 'users', :action => 'index'
  map.users_by_editor 'users/editor/:editor',
    :controller => 'users', :action => 'index'
  map.users_by_state 'users/state/:state',
    :controller => 'users', :action => 'index'

  map.namespace :api do |api|
    api.resources :bounties, :except => [:new, :edit]
  end

  map.resources :projects
  map.resources :votes
  map.resources :comments
  map.resources :tasks,
    :collection => {:wanted => :get, :unsolved => :get}
  map.resources :bounties,
    :collection => {:total_amount => :get, :add => :get},
    :member     => {:pay => :get}
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
