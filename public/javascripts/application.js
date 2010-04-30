function vote(f, path) {
  $.ajax({
    url: $(f).attr('action'),
    type: 'POST',
    dataType: 'json',
    timeout: 1000,
    data: $(f).serialize(),
    error: function(res) {
      console.log('Error Occured: %o', res)
      $(path).html(parseInt($(path).text()) + 1)
      $(f).hide()
    },
    success: function(res) {
      $(path).html(parseInt($(path).text()) + 1)
      $(f).hide()
    }
  })
  return false
}
