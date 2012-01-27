class Project < ActiveRecord::Base
   
   has_many :tickets, :dependent=>:delete_all   
   
   validates :name, :presence=>true
   
   validates :name, :uniqueness=>{:case_sensitive=>false}   
   
   validates :name, :length => {:maximum=>30}   

   has_many :permissions, :as=>:thing 
   
   scope :readable_by, lambda{ |user| joins(:permissions).where(:permissions=>{:action=>"view",:user_id=>user.id})}  

end
