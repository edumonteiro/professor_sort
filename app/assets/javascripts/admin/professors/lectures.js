$(function(){
  $.ajax({
    url: '/professor/lectures_graph',
    dataType: 'json'
  }).done(function(data){
  var data = {
      labels : $.map(data,function(v,i){ return i}),
      datasets : [
        {
          label: "Blood sugar level",
          fillColor : "rgba(220,220,220,0.2)",
          strokeColor : "rgba(220,220,220,1)",
          pointColor : "rgba(220,220,220,1)",
          pointStrokeColor : "#fff",
          pointHighlightFill : "#fff",
          pointHighlightStroke : "rgba(220,220,220,1)",
          data: $.map(data,function(v,i){ return v})
        }
      ]
  };
  var option = {};

  var ctx = document.getElementById("lectureChart").getContext("2d");
  var lineChart = new Chart(ctx).Line(data,option)

  })
})