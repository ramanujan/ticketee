class Project < ActiveRecord::Base

   validates :name, :presence=>true
   validates :name, :uniqueness=>{:case_sensitive=>false}   

end