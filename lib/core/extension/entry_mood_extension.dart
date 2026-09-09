import 'package:kotik/core/model/diary/diary_model.dart';

extension EntryMoodExtension on CatMood {
  String get title {
    switch (this) {
      case CatMood.angry:
        return 'Злой';
      case CatMood.cute:
        return 'Милый';
      case CatMood.displeased:
        return 'Недовольный';
      case CatMood.funny:
        return 'Веселый';
      case CatMood.hungry:
        return 'Голодный';
      case CatMood.mischievous:
        return 'Вредный';
      case CatMood.sleepy:
        return 'Сонный';
      case CatMood.strange:
        return 'Странный';
    }
  }

  String get emoji {
    switch (this) {
      case CatMood.angry:
        return '😾';
      case CatMood.cute:
        return '🥰';
      case CatMood.displeased:
        return '😒';
      case CatMood.funny:
        return '😸';
      case CatMood.hungry:
        return '🍽️';
      case CatMood.mischievous:
        return '😼';
      case CatMood.sleepy:
        return '😴';
      case CatMood.strange:
        return '🤨';
    }
  }
}
