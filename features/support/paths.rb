module NavigationHelpers
  
  def path_to page_name
  
     case page_name
        when /the home\s?page/ then '/'
     end
  
  end
  
end
World(NavigationHelpers)