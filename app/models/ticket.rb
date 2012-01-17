class Ticket < ActiveRecord::Base

 belongs_to :project
 belongs_to :user
 validates  :title, :presence=>true, :length=>{:maximum=>30} 
 validates  :description, :presence=>true, :length=>{:minimum=>8}
   
end
