String formatNumber(int number) {
  if (number >= 1000000000) {
    return '${(number / 1000000000).toStringAsFixed(1).replaceAll('.0', '')}B'; // Для миллиардов
  } else if (number >= 1000000) {
    return '${(number / 1000000).toStringAsFixed(1).replaceAll('.0', '')}M'; // Для миллионов
  } else if (number >= 1000) {
    return '${(number / 1000).toStringAsFixed(1).replaceAll('.0', '')}K'; // Для тысяч
  } else {
    return number.toString(); 
  }
}
