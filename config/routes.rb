ActionController::Routing::Routes.draw do |map|
  map.resources :users

  map.github_hook 'touch-me', :controller => 'users', :action => 'update'
    
  map.connect ':id', :controller => 'static_pages', :action => :show, :id => 'home'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
