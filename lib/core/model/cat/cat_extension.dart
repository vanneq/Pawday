import 'package:kotik/core/model/cat/cat_model.dart';

extension CatColorationAssets on CatColoration {
  String get imagePath {
    switch (this) {
      case CatColoration.black:
        return 'assets/cats/black_cat.png';
      case CatColoration.white:
        return 'assets/cats/white_cat.png';
      case CatColoration.ginger:
        return 'assets/cats/ginger_cat.png';
      case CatColoration.tabby:
        return 'assets/cats/tabby_cat.png';
      case CatColoration.tricolor:
        return 'assets/cats/tricolor_cat.png';
      case CatColoration.gray:
        return 'assets/cats/gray_cat.png';
      case CatColoration.brown:
        return 'assets/cats/brown_cat.png';
    }
  }
}

extension CatColorationTitle on CatColoration {
  String get title {
    switch (this) {
      case CatColoration.ginger:
        return 'Рыжий';
      case CatColoration.black:
        return 'Черный';
      case CatColoration.gray:
        return 'Серый';
      case CatColoration.white:
        return 'Белый';
      case CatColoration.brown:
        return 'Коричневый';
      case CatColoration.tricolor:
        return 'Трехцветный';
      case CatColoration.tabby:
        return 'Полосатый';
    }
  }
}
