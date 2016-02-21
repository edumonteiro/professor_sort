$(go);

$(document).on('page:load',go);

function go(){
    var msg = new SpeechSynthesisUtterance($('.alert-success div').text());
    msg.rate = 1;
    msg.lang = "en-EN";
    window.speechSynthesis.speak(msg);
}
