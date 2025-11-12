DateTime convertTime(time) {
  final now = DateTime.now();

  final selectedTime = DateTime(
    now.year,
    now.month,
    now.day,
    time.hour,
    time.minute,
  );

  return selectedTime;
}
