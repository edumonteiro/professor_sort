$(function(){  
  var msg = new SpeechSynthesisUtterance($('.alert div').text());
  msg.rate = 1;
  msg.lang = "es-ES";
  window.speechSynthesis.speak(msg);
})