class ListItems {
  String? title;
  String? text;
  DateTime? selectedDayTime;
  DateTime? selectedTime;

  ListItems(
      {required this.title,
      required this.text,
      required this.selectedDayTime,
      this.selectedTime});
}
