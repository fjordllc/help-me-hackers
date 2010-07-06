$(function(){
  var markedit = $('textarea').markedit({
    'preview': false
  });
  $(markedit).markeditBindAutoPreview($('.preview'));
});
