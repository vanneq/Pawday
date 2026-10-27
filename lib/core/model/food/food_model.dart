enum FoodType { fish, feed, treats }

class FoodModel {
  final FoodType type;
  final String name;
  final String imagePath;
  final int satietyPercent;

  const FoodModel({
    required this.type,
    required this.name,
    required this.imagePath,
    required this.satietyPercent,
  });
}

const foods = [
  FoodModel(
    type: FoodType.fish,
    name: 'Рыба',
    imagePath: 'assets/food/fish.png',
    satietyPercent: 15,
  ),
  FoodModel(
    type: FoodType.feed,
    name: 'Корм',
    imagePath: 'assets/food/feed.png',
    satietyPercent: 10,
  ),
  FoodModel(
    type: FoodType.treats,
    name: 'Лакомство',
    imagePath: 'assets/food/treats.png',
    satietyPercent: 20,
  ),
];
