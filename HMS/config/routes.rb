ActionController::Routing::Routes.draw do |map|
  
  
  map.root :controller => "users", :action=>"home"
  
  map.resources :users,:collection=> {:home => [:get], :logout => [:get], :login => [:get]}
  
  map.resources :doctors,:member=>{:view_appointments=>[:get]}
  
  map.resources :admins, :collection=> {:view_doctor=>[:get], :view_patient=>[:get],
    :new_room=>[:get],:create_new_room=>[:post],
    :new_bed=>[:get],:create_new_bed=>[:post],:ajax_bed_view=>[:get],:view_bed=> [:get],
    :all_registration=>[:get], :new_registration=>[:get],:create_new_registration=>[:post]},
    :member=>{:delete_bed=> [:delete],:delete_room=>[:delete],:delete_registration=>[:delete]}
  
  map.resources :patients,:collection=>{:view_patient=> [:get],:list_available_doctors=>[:get]},
    :member=>{:delete_appointments=>[:delete],:view_appointments=>[:get],:new_appointment=>[:get],:create_new_appointment=>[:post]}
  
  map.resources :departments
  
  map.resources :users, :member => { :avatars => [:get] }
    
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
