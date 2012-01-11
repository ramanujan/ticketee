class Project < ActiveRecord::Base
   
   has_many :tickets
   
   validates :name, :presence=>true
   validates :name, :uniqueness=>{:case_sensitive=>false}   
   validates :name, :length => {:maximum=>40}   
end
