jQuery(document).ready(() ->
  hljs.tabReplace = '  '
  hljs.initHighlighting()


  src = jQuery("#source")
  src.sourceDemo(
    classPref: "srcdemo",
    messageBox: jQuery("#leftcol")
  )

  src.on("changestate", (e, num) ->
    jQuery("#statenumber").val(num);
    p = 100 * num / Math.max($(this).data("slides_off").length, $(this).data("slides_on").length)
    jQuery("#progressbar").find("div.bar").css("width", "#{p}%")
  )

  jQuery(document).on("keydown", (e) ->
    switch e.keyCode
      when 39 then src.sourceDemo('next')
      when 37 then src.sourceDemo('prev')
  )



)
