authorization do
  
  role :guest do
    has_permission_on :users, :to => [:login,:login_attempt,:logout,:home]
    has_permission_on [:patients], :to => [:index,:new,:create]
    
  end
  
  role :admin do
    has_permission_on :admins, :to => [:index,:view_doctor,:view_patient,:view_bed,:new_room,:create_new_room,:delete_room,
      :new_bed,:create_new_bed,:delete_bed,:ajax_bed_view,:all_registration,:new_registration,:create_new_registration,:delete_registration]
    has_permission_on [:departments], :to => [:index,:new,:create,:destroy]
    has_permission_on [:doctors], :to => [:new,:create,:destroy]
    has_permission_on [:patients], :to => [:destroy]
    has_permission_on [:users], :to => [:logout]
    
  end
  
  role :doctor do
    
    has_permission_on :doctors, :to => [:index,:edit,:update,:destroy,:view_appointments]
    has_permission_on [:users], :to => [:logout]
    
  end
 
  role :patient do
    
    has_permission_on :patients, :to => [:index,:edit,:update,:destroy,:view_appointments,:new_appointment,:create_new_appointment,:list_available_doctors]
    has_permission_on [:users], :to => [:logout]
   	  
  end
  
end
