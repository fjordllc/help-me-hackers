function vote(f, path) {
  $.ajax({
    url: $(f).attr('action'),
    type: 'POST',
    dataType: 'json',
    timeout: 1000,
    data: $(f).serialize(),
    error: function(){ alert('Error Occured') },
    success: function(res) {
      $(path).html(res.count)
    }
  })
  return false
}
