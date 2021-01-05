String trimDate(DateTime date) {
  return date.toString().split(' ')[0].replaceAll('-', '/');
}
