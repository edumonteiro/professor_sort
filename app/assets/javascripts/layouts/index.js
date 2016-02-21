$(go);

$(document).on('page:load',go);

function go(){
  if ($('.alert strong').text() === 'Success!'){
    var msg = new SpeechSynthesisUtterance('Successfully updated to' + $('.jumbotron h2 strong').text());
    msg.rate = 1;
    msg.lang = "es-ES";
    window.speechSynthesis.speak(msg);
  }
}
