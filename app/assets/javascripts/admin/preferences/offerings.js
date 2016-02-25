$(go);

$(document).on('page:load',go);

function go(){
  $("#major_service_buttons button").eq(0).click(function() {
    $('html, body').animate({
        scrollTop: $("#main_container>h2").eq(0).offset().top -60
    }, 500);
});
  $("#major_service_buttons button").eq(1).click(function() {
    $('html, body').animate({
        scrollTop: $("#main_container>h2").eq(1).offset().top - 60
    }, 500);
});


}