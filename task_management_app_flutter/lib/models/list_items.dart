class ListItems {
  String? title;
  String? text;
  String? selectedTime;
  String? selectedDate;

  ListItems(
      {required this.title,
      required this.text,
      this.selectedDate,
      this.selectedTime});
}
