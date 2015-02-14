# -*- encoding: utf-8 -*-

#= require Caret.js/dist/jquery.caret
#= require At.js/dist/js/jquery.atwho
#= require jquery.html5-fileupload

window.Markdown =

  appendImageFromUpload : (srcs) ->
    txtBox = $(".markdown-editor")
    caret_pos = txtBox.caret('pos')
    src_merged = ""
    for src in srcs
      src_merged = "![](#{src})\n"
    source = txtBox.val()
    before_text = source.slice(0, caret_pos)
    txtBox.val(before_text + src_merged + source.slice(caret_pos+1, source.count))
    txtBox.caret('pos', caret_pos + src_merged.length)
    txtBox.focus()

  # 上传图片
  initUploader : () ->
    $("#markdown-uploader-btn").bind "click", () ->
      $(".markdown-editor").focus()
      $("#markdown-uploader-image").click()
      return false

    fileIpt = $("#markdown-uploader-image")
    uploaderUrl = "/photos"

    if $("input[name='_method']").length == 1
      uploaderUrl = fileIpt.closest("form")[0].attributes["action"].value + uploaderUrl;
    opts =
      url :  uploaderUrl
      type : "POST"
      beforeSend : () ->
        $("#markdown-uploader-btn").hide()
        $("#markdown-uploader-btn").before("<span class='loading'>上传中...</span>")
      success : (result, status, xhr) ->
        Markdown.restoreUploaderStatus()
        Markdown.appendImageFromUpload([result])
      error : (result, status, errorThrown) ->
        Markdown.restoreUploaderStatus()
        alert(errorThrown)
    
    fileIpt.fileUpload opts
    return false
  # 恢复上传状态
  restoreUploaderStatus : () ->
    $("#markdown-uploader-btn").parent().find("span.loading").remove()
    $("#markdown-uploader-btn").show()

  preview: (body) ->
    $("#preview").text "Loading..."

    $.post "/markdown/preview",
      "body": body,
      (data) ->
        $("#preview").html data.body
      "json"

  hookPreview: (switcher, textarea) ->
    # put div#preview after textarea
    previewBox = $(document.createElement("div")).attr "id", "preview"
    previewBox.addClass("markdown-body")
    $(textarea).after previewBox
    previewBox.hide()

    $(".edit a",switcher).click ->
      $(".preview",switcher).removeClass("active")
      $(this).parent().addClass("active")
      $(previewBox).hide()
      $(textarea).show()
      $(textarea).focus()
      false
    $(".preview a",switcher).click ->
      $(".edit",switcher).removeClass("active")
      $(this).parent().addClass("active")
      $(previewBox).show()
      $(textarea).hide()
      Markdown.preview($(textarea).val())
      false

  initCloseWarning: (el, msg) ->
    return false if el.length == 0
    msg = "离开本页面将丢失未保存页面!" if !msg
    $("input[type=submit]").click ->
      $(window).unbind("beforeunload")
    el.change ->
      if el.val().length > 0
        $(window).bind "beforeunload", (e) ->
          if $.browser.msie
            e.returnValue = msg
          else
            return msg
      else
        $(window).unbind("beforeunload")

  # 往话题编辑器里面插入代码模版
  appendCodesFromHint : (language='') ->
    txtBox = $(".markdown-editor")
    caret_pos = txtBox.caret('pos')
    prefix_break = ""
    if txtBox.val().length > 0
      prefix_break = "\n"
    src_merged = "#{prefix_break }```#{language}\n\n```\n"
    source = txtBox.val()
    before_text = source.slice(0, caret_pos)
    txtBox.val(before_text + src_merged + source.slice(caret_pos+1, source.count))
    txtBox.caret('pos',caret_pos + src_merged.length - 5)
    txtBox.focus()

  init : ->
    bodyEl = $("body")

    Markdown.initCloseWarning($("textarea.closewarning"))

    Markdown.initUploader()

    Markdown.hookPreview($(".editor-toolbar"), $(".markdown-editor"))

    # pick up one lang and insert it into the textarea
    $("a.insert_code").on "click", ->
      # not sure IE supports data or not
      Markdown.appendCodesFromHint($(this).data('content') || $(this).attr('id') )

$(document).ready ->
  if $('.editor-toolbar').length == 1
    Markdown.init()
