String shortenNumberToString(String quantity) {
  if(quantity == null) return '0';
  return quantity.length <= 3
      ? quantity
      : (quantity.length == 4
      ? '${quantity.substring(0, 1)}k'
      : (quantity.length == 5
      ? '${quantity.substring(0, 2)}k'
      : '${quantity.substring(0, 3)}k'));
}