jQuery ->
    $("li.dropdown").hover (ev) -> $(this).children('ul').toggleClass 'hover'

    # for mobile touches instead of hovers -- using links instead for now
    if "ontouchstart" of document.documentElement
        $("li.dropdown a").bind("touchstart", (ev) ->
            $(this).siblings('ul').toggleClass "hover"
            if $(this).siblings('ul').length
                ev.preventDefault()
                ev.stopImmediatePropagation()
        )
