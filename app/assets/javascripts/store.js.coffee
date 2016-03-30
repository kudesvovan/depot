# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "ready page:change", ->
	$('.store .entry > img').unbind('click') # снимаемся с клика
	$('.store .entry > img').click ->        # эффект по клику
		$(this).parent().find(':submit').click()