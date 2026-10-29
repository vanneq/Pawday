int calculateSatiety({
  required int hungry,
  required DateTime updatedAt,
  DateTime? now,
}) {
  final currentTime = (now ?? DateTime.now()).toUtc();
  final updateTime = updatedAt.toUtc();
  final elapsed = currentTime.difference(updateTime);
  final elapsedHours = elapsed.isNegative ? 0 : elapsed.inHours;

  return (hungry - elapsedHours * 5).clamp(0, 100);
}
