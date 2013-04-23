# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('form')
    .on "ajax:before", (evt, xhr, settings) ->
       console.log('before')
    .on "ajax:beforeSend", (evt, xhr, settings) ->
       console.log('beforeSend')
    .on "ajax:success", (evt, xhr, settings) ->
       console.log('success')
    .on "ajax:complete", (evt, xhr, settings) ->
       console.log('complete')
    .on "ajax:error", (jqXHR, textStatus, errorThrown) ->
       console.log('error = ' + errorThrown)

$ ->
  $('video,audio').mediaelementplayer()
  AddressPickerRails.Pickers.applyOnReady()
  $('.arrow, [class^=arrow-]').bootstrapArrows()

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
        $(this).parent().parent().fadeOut(500).remove()
        
        
$ ->
  $('a[data-toggle="tab"]').each (index, element) =>
    if $(element).attr("href") == window.location.hash
      $(element).tab('show')
      
$ ->
  $('.change-photo-link').click ->
    $('.nav-tabs a:last').click()
      
$ ->
  $('.sortable').sortable
    items: 'li'

    update: (e, ui) ->
      item_id = ui.item.data('item-id')
      position = ui.item.index()
      user_id = $(this).data('user-id')
      content_type = $(this).data('content-type')
      item_data = {}
      item_data[content_type] = {row_order_position: position}
      
      $.ajax(
        type: 'PUT'
        url: ('/users/' + user_id + '/' + content_type  + 's/' + item_id)
        dataType: 'json'
        data: item_data
      )

reset_profile_links = () ->
  profile_id = $(this).parents('li').data('item-id')
  user_id = $('#photo_list').data('user-id')
  $("#photo_list").children().each ->
    item_id = $(this).data('item-id')
    profile_link = $(this).find('.profile-link')
    if(item_id == profile_id)
      profile_link.html('Selected Profile')
    else
      profile_link.html('<a href="/users/' + user_id + '/photos/' + item_id + '/update_profile" class="btn btn-tiny" data-method="put" data-remote="true" rel="nofollow">Profile Picture</a>')
  $('.profile-link a').click(reset_profile_links)

$ ->
  $('.post-delete').click -> 
    $(this).parent().parent().fadeOut(500).remove()
    
$ ->
  $('.delete-link').click -> 
    $(this).parent().parent().parent().parent().fadeOut(500, =>
        $(this).parent().parent().parent().parent().remove()
    )
    
$ ->
  $('.profile-link a').click(reset_profile_links)

      
$ ->
  $("#media-accordion form")
    .on "ajax:beforeSend", (evt, xhr, settings) ->
      $(this).find('input[type=text], input[type=submit]')
        .addClass('uneditable-input')
        .attr('disabled', 'disabled');
    .on "ajax:success", (evt, data, status, xhr) ->
      $(this).find('input[type=text], input[type=submit]').removeClass('uneditable-input')
                                      .removeAttr('disabled', 'disabled')
      if xhr.responseText.substring(0, 5) != "alert"
        $(this).find('input[type=text]').val('')
        file_input = $(this).find('input[type=file]')
        if $(this).find('input[type=file]').count > 0
          file_input .wrap('<form>').closest('form').get(0).reset()
          file_input .unwrap()
        
        $($(this).parent().siblings('ul')[0]).append(xhr.responseText).children(":last").hide().show('fast')
        $('.delete-link').click -> 
          $(this).parent().parent().parent().parent().fadeOut(500, =>
              $(this).parent().parent().parent().parent().remove()
          )
        $('.profile-link a').click(reset_profile_links)