do ( $ = jQuery ) ->
  $(document).ready(() ->
    hljs.tabReplace = '  '
    hljs.initHighlighting()


    src = $("#source")
    src.sourceDemo(
      classPref: "srcdemo",
      messageBox: $("#leftcol")
    )

    src.on("changestate", (e, num) ->
      $("#statenumber").val(num);
      p = 100 * num / Math.max($(this).data("slides_off").length, $(this).data("slides_on").length)
      $("#progressbar").find("div.bar").css("width", "#{p}%")
    )

    $(document).on("keydown", (e) ->
      switch e.keyCode
        when 39 then src.sourceDemo('next')
        when 37 then src.sourceDemo('prev')
    )

    $("a[rel^='prettyPhoto']").prettyPhoto(
      'social_tools': ''
      'default_height': 400
    );
  )
