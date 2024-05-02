extension DateAndHourFormatter on String? {
  String? formatDateAndHour() {
    if (this == null || this!.isEmpty) return '';
    DateTime currentDate = DateTime.parse(this!);

    return '${currentDate.day}/'
        '${currentDate.month}/'
        '${currentDate.year} '
        '${currentDate.hour.toString().padLeft(2, '0')}:'
        '${currentDate.minute.toString().padLeft(2, '0')}';
  }
}

extension DateFormatter on String {
  String formatDate() {
    DateTime currentDate = DateTime.parse(this);

    return '${currentDate.day}/'
        '${currentDate.month}/'
        '${currentDate.year} ';
  }
}
