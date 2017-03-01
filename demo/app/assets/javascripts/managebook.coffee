# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
changeColor('vertical_nav_manage');
@delete_book=()->
  result = raise_confirm('Do you want to delete this?')
  if !result
    event.preventDefault()
