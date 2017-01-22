# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

tweet_message = document.getElementById('tweet_message')
count = document.getElementById('count')

tweet_message.keyup = ->
  max = 140
  count.innerHTML = max - this.value.length



