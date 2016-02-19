$(document).on('page:load',function(){
  $('.edit_offering').submit(function(event){
    // event.preventDefault();
    var sched = [];
    for(var i = 0 ; i < $('#timeforms').children().length/2; i++){
      day = "#day" + i;
      time = "#time" + i;
      sched.push($(day).val());
      sched.push($(time).val());
    }
    $('#offering_schedule').val(sched.join(""));
  });



});

