module NavigationHelpers
  
  def path_to page_name
  
     case page_name
        when /home\s?page/ then '/'
        when /project show page for "([^"]*)"/ then project_path( Project.find_by_name!($1) )  
     end
  
  end
  
end
World(NavigationHelpers)