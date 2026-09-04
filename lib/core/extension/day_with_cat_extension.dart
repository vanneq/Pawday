import 'package:kotik/core/model/cat/cat_model.dart';

extension DayWithCatExtension on CatModel {
  int get daysWithCat {
    final now = DateTime.now();
    final startDate = DateTime(createdAt.year, createdAt.month, createdAt.day);
    final today = DateTime(now.year, now.month, now.day);
    return today.difference(startDate).inDays + 1;
  }
}
