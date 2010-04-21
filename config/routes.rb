ActionController::Routing::Routes.draw do |map|
  map.resources :answers
  map.problems_by_category 'problems/category/:name',
    :controller => 'problems', :action => 'index'
  map.resources :problems, :collection => {:wanted => :get, :unsolved => :get}
  map.resource :account, :only => [:show, :edit, :update, :destroy]
  map.resource :user_session, :only => [:new, :create, :destroy]
  map.root :controller => 'top'
  map.root_for_yahoo 'index.html', :controller => 'top'
  map.users 'users', :controller => 'users', :action => 'index'
  map.user ':login', :controller => 'users', :action => 'show'
end
