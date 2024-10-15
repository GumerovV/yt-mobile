String timeAgo(DateTime date) {
  final Duration diff = DateTime.now().difference(date);
  
  if (diff.inSeconds < 60) {
    return 'только что';
  } else if (diff.inMinutes < 60) {
    return '${diff.inMinutes} минут назад';
  } else if (diff.inHours < 24) {
    return '${diff.inHours} часов назад';
  } else if (diff.inDays < 7) {
    return '${diff.inDays} дней назад';
  } else if (diff.inDays < 30) {
    final int weeks = (diff.inDays / 7).floor();
    return '$weeks ${_pluralize(weeks, "неделя", "недели", "недель")} назад';
  } else if (diff.inDays < 365) {
    final int months = (diff.inDays / 30).floor();
    return '$months ${_pluralize(months, "месяц", "месяца", "месяцев")} назад';
  } else {
    final int years = (diff.inDays / 365).floor();
    return '$years ${_pluralize(years, "год", "года", "лет")} назад';
  }
}

String _pluralize(int number, String one, String few, String many) {
  if (number % 10 == 1 && number % 100 != 11) {
    return one;
  } else if (number % 10 >= 2 && number % 10 <= 4 && (number % 100 < 10 || number % 100 >= 20)) {
    return few;
  } else {
    return many;
  }
}

