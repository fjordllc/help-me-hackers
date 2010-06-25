function numerize(str) {
  return parseInt(str.replace(/[^0-9]+/g, ''))
}

function number_format(num){
  return num.toString().replace( /([0-9]+?)(?=(?:[0-9]{3})+$)/g , '$1,' )
}
