jQuery ->
    $("#email-section").hide()
    $("#tech-stack").hide()
    $("#btn-calc").on("click", calculate)
    $("#input-price").on("keypress", detect_enter)
    $("#gear").css("visibility", "hidden")
    $("#btn-tech-stack").on("click", show_tech_stack)
    $(window).on("resize", on_window_resize)

calculate =->
    if validate()
        $("#gear").css("visibility", "visible")
        $.ajax
            dataType: "html"
            url: "/ajax"
            data:
                price: $("#input-price").val()
            success: (data) ->
                $(".result").html(data)
                $("#email-section").show()
            complete: ->
                $("#gear").css("visibility", "hidden")
    else
        $(".result").html("")

validate =->
    price = $("#input-price").val()
    if (/^[-+]?([0-9]*[.,][0-9]+$|^[0-9]+$)/.test(price))
        $("#input-price").val(price.replace(",", "."))
        $(".error").html("")
        return true
    else
        $(".error").html("This is not a number!")
        $("#email-section").hide()
        return false

detect_enter = (event) ->
    if (event.keyCode == 13)
        calculate()

move_tech_stack =->
    left = $("#btn-tech-stack").offset().left - 5
    bottom = $(document).height() -
             $("#btn-tech-stack").offset().top +
             get_dimension_from_px($(".footer").css("padding-top"))
    $("#tech-stack").css("left", left)
    $("#tech-stack").css("bottom", bottom)

get_dimension_from_px = (dim) ->
    return parseInt(dim.replace("px", ""), 10)

show_tech_stack =->
    move_tech_stack()
    $("#tech-stack").slideToggle()

on_window_resize =->
    move_tech_stack()
