# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# -- Creo due amministratori -- 

admin_user = User.create! :email=>"domenicodeg@gmail.com",:password=>"cravatta"
admin_user.admin=true
admin_user.confirm! 

admin_user = User.create! :email=>"admin@ticketeefoodomain123.com",:password=>"password"
admin_user.admin=true
admin_user.confirm! 

#   Creo 10 utenti normali


10.times do |index|
  
    user =  User.create! :email=>"user_#{index}@ticketeefoodomain123.com",:password=>"cravatta"  
    user.confirm!   
end


# Creo 10 progetti  

10.times do |index|
    
    project = Project.create! :name=>"Ticketee_#{index}_project" 
     
end

# A qualche progetto associo un paio di tickets

projects = Project.all

projects.each do |project|
  
     project.tickets.create! :title=>"A project_#{project.id}_ticket",
                             :description=>"A foo tickets. Automatic seeded",
                             :user=>admin_user if project.id.odd?       
end



# Bisogna anche creare degli stati. Iniziamo con la creazione di Open, Closed, New 

State.create!(:name       => "New",
              :background => "#85ff00",
              :color      => "white"
              )

State.create!(:name       => "Open",
              :background => "#00cffd",
              :color      => "white"
              )

State.create!(:name       => "Closed",
              :background => "black",
              :color      => "white"
              )
