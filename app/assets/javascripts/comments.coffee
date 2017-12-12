# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('click', 'a.edit-comment', (evt) ->
  evt.preventDefault()
  commentId = $(evt.currentTarget).data('comment-id')
  $("#comment-#{commentId}-content").addClass('hidden')
  $("#comment-#{commentId}-edit").removeClass('hidden')
  $("#comment-new").addClass('hidden')
)
