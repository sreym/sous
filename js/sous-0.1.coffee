do ( $ = jQuery ) ->
  stateItemComp = (a,b) ->
    if a.data?("num") and b.data?("num")
      a.data("num") - b.data("num")

  getclasars = (classAttr, classNames = false) ->
    el = this
    classList = classAttr.split(/\s+/gi)
    res = []
    $.each(classList, (j, cls) ->
      classRegExp = new RegExp("^#{el.data("settings").classPref}(\\d+)?-(\\d+)?$", "g")
      clasAr = classRegExp.exec(cls)
      if clasAr and ( clasAr[1] or clasAr[2] )
        if not clasAr[1]
          clasAr[1] = 0
        else
          clasAr[1] = parseInt(clasAr[1])
        if not clasAr[2]
          clasAr[2] = Infinity
        else
          clasAr[2] = parseInt(clasAr[2])

        if classNames
          res.push([clasAr[1], clasAr[2], cls])
        else
          res.push([clasAr[1], clasAr[2]])
    )
    res

  hide = ( it, immed = true ) ->
    it.hide()
    curNum = this.data('current')
    for classIt in getclasars.apply(this, [it.attr("class"), true])
      if classIt[0] > curNum or curNum >= classIt[1]
        this.data("settings").messageBox.find(".#{classIt[2]}").hide()

  show = ( it, immed = true ) ->
    it.show()
    curNum = this.data('current')
    for classIt in getclasars.apply(this, [it.attr("class"), true])
      if classIt[0] <= curNum < classIt[1]
        this.data("settings").messageBox.find(".#{classIt[2]}").show()


  methods =
    init : ( options ) ->
      settings = $.extend(
        'classPref' : 'srcdemo',
        'messageBox' : $(document.body)
        options)
      el = $(this)
      el.data('slides_on', [])
      el.data('slides_off', [])
      el.data('states', [ [] ])
      el.data('allspans', [])
      el.data('settings', settings)
      el.data('current', 0)

      spans = el.find("span")
      $.each(spans, (i, item) ->
        spanItem = $(item)
        spanItem.data("num", i)
        classList = getclasars.apply(el, [spanItem.attr("class")])
        $.each(classList, (j, clasAr) ->
          if el.data('slides_on')[clasAr[0]] instanceof Array
            el.data('slides_on')[clasAr[0]].push(spanItem)
          else
            el.data('slides_on')[clasAr[0]]  = [spanItem]

          if clasAr[0] isnt 0
            hide.apply(el, [spanItem])
          else
            el.data('states')[0].push(spanItem)

          if el.data('allspans').indexOf(spanItem) < 0
            el.data('allspans').push(spanItem)

          if clasAr[1] isnt Infinity
            if el.data('slides_off')[clasAr[1]] instanceof Array
              el.data('slides_off')[clasAr[1]].push(spanItem)
            else
              el.data('slides_off')[clasAr[1]] = [spanItem]
        )
      )

      el.data('states')[0].sort(stateItemComp)
      el.data('allspans').sort(stateItemComp)
      for Ar in el.data('slides_on')
        if Ar instanceof Array
          Ar.sort(stateItemComp)
      for Ar in el.data('slides_off')
        if Ar instanceof Array
          Ar.sort(stateItemComp)

    next : ( ) ->
      el = $(this)
      curNum = el.data('current')
      if curNum < Math.max(el.data('slides_off').length, el.data('slides_on').length)
        el.data('current', curNum + 1)
        state = el.data('states')[curNum + 1] ? undefined

        if not state
          state = el.data('states')[curNum].slice()

          if el.data('slides_off')[curNum + 1] instanceof Array
            for it in el.data('slides_off')[curNum + 1]
              i = state.indexOf(it)
              state.splice(i, 1) if i >= 0

          if el.data('slides_on')[curNum + 1] instanceof Array
            for it in el.data('slides_on')[curNum + 1]
              i = state.indexOf(it)
              state.push(it) if i < 0

          state.sort(stateItemComp)
          el.data('states')[curNum + 1] = state

        for it in el.data('allspans')
          if state.indexOf(it) >= 0
            if it.is(":hidden")
              show.apply(el, [it])
              it.addClass("just-showed")
            else
              it.removeClass("just-showed")
          else
            if not it.is(":hidden")
              hide.apply(el, [it])

        el.trigger("changestate", curNum + 1)


    prev : ( ) ->
      el = $(this)
      curNum = el.data('current')
      if curNum - 1 >= 0
        el.data('current', curNum - 1)
        state = el.data('states')[curNum - 1]
        statePre = el.data('states')[curNum - 2]

        for it in el.data('allspans')
          if state.indexOf(it) >= 0
            if it.is(":hidden")
              show.apply(el,[it])

            if statePre.indexOf(it) < 0
              it.addClass("just-showed")
            else
              it.removeClass("just-showed")
          else
            if not it.is(":hidden")
              hide.apply(el,[it])
        el.trigger("changestate", curNum - 1)


  $.fn.sourceDemo = ( method, ARGS... ) ->
    this.each( () ->
      if methods[method]
        methods[ method ].apply( this, ARGS)
      else if typeof method is 'object' or  ! method
        methods.init.apply( this, [method, ARGS...] )
      else
        $.error( "No method with name #{method}" )
    )
