String formatDate(DateTime date) {
  final String monthWithZero = '0${date.month}';
  final String dayWithZero = '0${date.day}';
  final formatDate = '${date.day < 10 
                      ? dayWithZero 
                      : date.day}/${date.month < 10 ? monthWithZero : date.month}/${date.year}';

  return formatDate;
}
