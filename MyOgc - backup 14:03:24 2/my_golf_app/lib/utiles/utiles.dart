class AppUtilities {
  static const mounthList = [
    'Gennaio',
    'Febbraio',
    'Marzo',
    'Aprile',
    'Maggio',
    'Giugno',
    'Luglio',
    'Agosto',
    'Settembre',
    'Ottobre',
    'Novembre',
    'Dicembre',
  ];

  static const initialMounthList = [
    'Gen',
    'Feb',
    'Mar',
    'Apr',
    'Mag',
    'Giu',
    'Lug',
    'Ago',
    'Set',
    'Ott',
    'Nov',
    'Dic',
  ];

 static  bool compareDate(
      DateTime initialDate, DateTime endDate, DateTime actualDate) {
   
    return (actualDate.isAfter(initialDate) && actualDate.isBefore(endDate)) ||
        (isSameDate(initialDate, actualDate) ||
            isSameDate(endDate, actualDate));
  }

 static bool isSameDate(DateTime dayOne, DateTime dayTwo) {
    return dayOne.year == dayTwo.year &&
        dayOne.month == dayTwo.month &&
        dayOne.day == dayTwo.day;
  }
}
