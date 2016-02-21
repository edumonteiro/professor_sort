$(go);

$(document).on('page:load',go);

function go(){
  $('#offering_course_id').change(function(){
    $('#timeforms').empty();
    $( '#timeforms' ).css('display','none');
    $.ajax({
      url:"/admin/courses/"+$(this).val(),
      dataType: "json"
    }).done(function(data){
        for(var i = 0; i < (data/2) ; i++){
          var day = "<p>Day<select id='day" +i+"'><option value='a'>Monday</option><option value='b'>Tuesday</option><option value='c'>Wednesday</option><option value='d'>Thursday</option><option value='e'>Friday</option></select></p>"
          var time =  "<p>Time<select id='time"+i+"'><option value='1'>8-10</option><option value='2'>10-12</option><option value='3'>12-14</option><option value='4'>14-16</option><option value='5'>16-18</option><option value='6'>18-20</option><option value='7'>19-21</option><option value='8'>21-23</option></select></p>"
          $('#timeforms').append(day).append(time);
        };
          $('#timeforms').show("slow");
      });
  });

  $('#new_offering').submit(function(event){
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
}

