function vote(f, path) {
  $.ajax({
    url: $(f).attr('action'),
    type: 'POST',
    dataType: 'json',
    timeout: 1000,
    data: $(f).serialize(),
    error: function(res) {
      console.log('Error Occured: %o', res)
    },
    success: function(res) {
      $(path).html(res.count)
      f.hide()
    }
  })
  return false
}
