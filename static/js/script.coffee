jQuery ->
    $("#email-section").hide()
    $("#btn-calc").on("click", calculate)
    $("#input-price").on("keypress", detect_enter)
    $("#gear").css("visibility", "hidden")

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
