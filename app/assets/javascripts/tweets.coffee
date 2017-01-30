# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

file_is_choised = ->
  $('#label_choise_image').css('background-color', '#0f0')

counter_characters = ->
  max = 140
  count = $('#tweet_message').val().length
  difference = max - count
  if difference >= 0
    $('#count_characters').text(difference)
    $('#count_characters').css('color', '#333333')
    $('#phrase_characters').text('characters left')
  else
    $('#count_characters').text(-difference)
    $('#count_characters').css('color', '#f00')
    $('#phrase_characters').text('characters over')



$ ->
  $('#tweet_image').change(file_is_choised)
  $('#tweet_message').keyup(counter_characters)
