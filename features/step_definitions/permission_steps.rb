=begin

   And "user1@ticketee.com" can view the "TextMate 2" project 
   And "user@ticketee.com" can create tickets in the "Internet Explorer" project

=end

permission_step_regexp = /^"([^"]*)" can ([^"]*?) o?n?\s?the "([^"]*)" project/
 
 


Given permission_step_regexp do |user_email,permission,project_name|

  create_permission(user_email,permission,project_name)
  
  
end



def create_permission(user_email,action,project_name)
  
    
   permission = Permission.create! :user=>User.find_by_email!(user_email),
                                   :thing=>Project.find_by_name!(project_name),
                                   :action=>action  
  
  
end




