# -*- encoding: utf-8 -*-

#= require base
#= require jquery-timeago/jquery.timeago
#= require bootstrap-sass-official/assets/javascripts/bootstrap-sprockets
#= require social-share-button
#= require markdown_editor

$ ->
  $('abbr.timeago').timeago()
  $('input[data-behavior=auto-select]').click ->
    @select()
    return
  $('input[data-behavior=focus]:first').focus().select()
  $('#embed-link').click (e) ->
    e.preventDefault()
    $('.embed-box').slideDown 'fast'
    return
  $('[data-toggle="popover"]').popover html: true
  return