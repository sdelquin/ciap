// Generated by CoffeeScript 1.10.0
var calculate, detect_enter, get_dimension_from_px, move_tech_stack, on_window_resize, show_tech_stack, validate;

jQuery(function() {
  $("#email-section").hide();
  $("#tech-stack").hide();
  $("#btn-calc").on("click", calculate);
  $("#input-price").on("keypress", detect_enter);
  $("#gear").css("visibility", "hidden");
  $("#btn-tech-stack").on("click", show_tech_stack);
  return $(window).on("resize", on_window_resize);
});

calculate = function() {
  if (validate()) {
    $("#gear").css("visibility", "visible");
    return $.ajax({
      dataType: "html",
      url: "/ajax",
      data: {
        price: $("#input-price").val()
      },
      success: function(data) {
        $(".result").html(data);
        return $("#email-section").show();
      },
      complete: function() {
        return $("#gear").css("visibility", "hidden");
      }
    });
  } else {
    return $(".result").html("");
  }
};

validate = function() {
  var price;
  price = $("#input-price").val();
  if (/^[-+]?([0-9]*[.,][0-9]+$|^[0-9]+$)/.test(price)) {
    $("#input-price").val(price.replace(",", "."));
    $(".error").html("");
    return true;
  } else {
    $(".error").html("This is not a number!");
    $("#email-section").hide();
    return false;
  }
};

detect_enter = function(event) {
  if (event.keyCode === 13) {
    return calculate();
  }
};

move_tech_stack = function() {
  var bottom, left;
  left = $("#btn-tech-stack").offset().left - 5;
  bottom = $(document).height() - $("#btn-tech-stack").offset().top + get_dimension_from_px($(".footer").css("padding-top"));
  $("#tech-stack").css("left", left);
  return $("#tech-stack").css("bottom", bottom);
};

get_dimension_from_px = function(dim) {
  return parseInt(dim.replace("px", ""), 10);
};

show_tech_stack = function() {
  move_tech_stack();
  return $("#tech-stack").slideToggle();
};

on_window_resize = function() {
  return move_tech_stack();
};
