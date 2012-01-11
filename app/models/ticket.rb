class Ticket < ActiveRecord::Base

 belongs_to :project

 validates  :title, :presence=>true, :length=>{:maximum=>30} 
 validates  :description, :presence=>true, :length=>{:minimum=>8} 
   
 def title
      # Necessario overloading, per una corretta formattazione. 
      read_attribute(:title).downcase.capitalize
            
       
 end  
 
 def description
      # Necessario overloading, per una corretta formattazione. 
      read_attribute(:description).downcase.capitalize
            
       
 end    
   
   
end
