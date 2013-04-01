# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('video,audio').mediaelementplayer()
  AddressPickerRails.Pickers.applyOnReady();

$ ->
  $(".post-form")
    .on "ajax:beforeSend", (evt, xhr, settings) ->
      $(this).find('textarea')
        .addClass('uneditable-input')
        .attr('disabled', 'disabled');
    .on "ajax:success", (evt, data, status, xhr) ->
      $(this).find('textarea')
        .removeClass('uneditable-input')
        .removeAttr('disabled', 'disabled')
        .val('');
      $('#posts').prepend(xhr.responseText).children(":first").hide().show('fast').find('.post-delete').click ->
        $(this).parent().parent().fadeOut(500);
        
        
$ ->
  $('a[data-toggle="tab"]').each (index, element) =>
    if $(element).attr("href") == window.location.hash
      $(element).tab('show')
      
$ ->
  $('.sortable').sortable
    items: 'li'

    update: (e, ui) ->
      item_id = ui.item.data('item_id')
      position = ui.item.index()
      user_id = $(this).data('user_id')
      content_type = $(this).data('content_type')
      item_data = {}
      item_data[content_type] = {row_order_position: position}
      
      $.ajax(
        type: 'PUT'
        url: ('/users/' + user_id + '/' + content_type  + 's/' + item_id)
        dataType: 'json'
        data: item_data
      )

$ ->
  $('.post-delete, .video-delete').click -> 
    $(this).parent().parent().fadeOut(500);
  
$ ->
  $('.song-delete').click ->
    $(this).parent().parent().parent().fadeOut(500);

$ ->
  $(".song-form")
    .on "ajax:success", (evt, data, status, xhr) ->
      $('#song_list').append(xhr.responseText).children(":last").hide().show('fast')