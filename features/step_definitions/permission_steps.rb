=begin

   And "user1@ticketee.com" can view the "TextMate 2" project 
   And "user@ticketee.com" can create tickets in the "Internet Explorer" project

=end

permission_step_regexp = /^"([^"]*)" can ([^"]*?) o?n?\s?the "([^"]*)" project/
 
 


Given permission_step_regexp do |user_email,permission,project_name|

  create_permission(user_email,permission,project_name)
  
  
end

When /^I check "([^"]*)" for "([^"]*)"$/ do |permission, project_name|
    
=begin 
    
     Qui bisogna elaborare un po. Infatti viene reso dal browser qualcosa di simile : 
       
         <td>
                                              
           <input id="permissions_2_view" name="permissions[2][view]" type="checkbox" value="1" /> 
                                    
         </td>           

 


=end        
        
    project = Project.find_by_name!(project_name)
    
    permission=permission.downcase.gsub(" ","_")
    
    field_id = "permissions_#{project.id}_#{permission}"
    
    # Adesso invoco uno step già esistente in user_steps.rb 
    
    steps(%Q{When I check "#{field_id}"  })     
end



def create_permission(user_email,action,project_name)
  
    
   permission = Permission.create! :user=>User.find_by_email!(user_email),
                                   :thing=>Project.find_by_name!(project_name),
                                   :action=>action  
  
  
end




