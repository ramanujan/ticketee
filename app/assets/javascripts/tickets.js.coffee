# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(->
  $('a#add_another_file').click(->
    url = "/static_files/new?number=" + $('#static_files input').length
    $.get(url,(data)->
                 $('#static_files').append(data) 
    )
   )
  )
  







