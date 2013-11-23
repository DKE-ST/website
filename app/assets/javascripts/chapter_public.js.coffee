# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

resizeIt = ->
  textarea = $("#chapter_public_content")
  lines = textarea.val().split("\n")
  width = textarea.width()/6.5
  height = 1
  i = 0
  while i < lines.length
    linelength = lines[i].length
    height += Math.floor(linelength / width)  if linelength >= width
    i++
  height += lines.length
  textarea.height height * 20

$(document).keypress (e) ->
  resizeIt()
  
$(document).ready ->
  resizeIt()
  
#Event.observe "chapter_public_content", "keydown", resizeIt # you could attach to keyUp, etc if keydown doesn't work