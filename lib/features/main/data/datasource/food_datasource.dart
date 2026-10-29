import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kotik/core/model/food/food_model.dart';

class FoodDatasource {
  final FirebaseFirestore firestore;

  FoodDatasource({required this.firestore});

  Future<void> addFoodDrop(String userId, List<FoodType> gettingFood) async {
    final quantities = <FoodType, int>{};
    for (final type in gettingFood) {
      quantities.update(type, (quantity) => quantity + 1, ifAbsent: () => 1);
    }

    final inventoryRef = firestore
        .collection('users')
        .doc(userId)
        .collection('inventory');

    final batch = firestore.batch();
    for (final entry in quantities.entries) {
      final foodRef = inventoryRef.doc(entry.key.name);
      batch.set(foodRef, {
        'quantity': FieldValue.increment(entry.value),
      }, SetOptions(merge: true));
    }

    await batch.commit();
  }

  Stream<Map<FoodType, int>> watchInventory(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('inventory')
        .snapshots()
        .map((snapshot) {
          final inventory = <FoodType, int>{
            for (final type in FoodType.values) type: 0,
          };
          for (final doc in snapshot.docs) {
            final type = FoodType.values.byName(doc.id);
            final quantity = (doc.data()['quantity'] as num?)?.toInt() ?? 0;
            inventory[type] = quantity;
          }
          return inventory;
        });
  }

  Future<void> feedCat(String userId, String catId, FoodType foodType) async {
    final inventoryRef = firestore
        .collection('users')
        .doc(userId)
        .collection('inventory')
        .doc(foodType.name);

    final catRef = firestore
        .collection('users')
        .doc(userId)
        .collection('cats')
        .doc(catId);

    final food = foods.firstWhere((item) => item.type == foodType);
    await firestore.runTransaction((transaction) async {
      // читает остаток еды и данные кота
      final inventorySnapshot = await transaction.get(inventoryRef);
      final catSnapshot = await transaction.get(catRef);
      if (!catSnapshot.exists) {
        throw StateError('Кот не найден');
      }
      final quantity =
          (inventorySnapshot.data()?['quantity'] as num?)?.toInt() ?? 0;
      if (quantity < 1) {
        throw StateError('Упс, еда закончилась');
      }
      final currentSatiety =
          (catSnapshot.data()?['hungry'] as num?)?.toInt() ?? 0;

      final catData = catSnapshot.data()!;
      final now = DateTime.now().toUtc();
      final storedUpdatedAt = catData['satietyUpdatedAt'];
      final lastUpdatedAt = storedUpdatedAt is String
          ? DateTime.tryParse(storedUpdatedAt)?.toUtc() ?? now
          : now;
      final elapsed = now.difference(lastUpdatedAt);
      final elapsedHours = elapsed.isNegative ? 0 : elapsed.inHours;
      final decayedSatiety = (currentSatiety - elapsedHours * 5)
          .clamp(0, 100)
          .toInt();
      final updatedAt = lastUpdatedAt.add(Duration(hours: elapsedHours));

      final newSatiety = (decayedSatiety + food.satietyPercent)
          .clamp(0, 100)
          .toInt();

      transaction.update(inventoryRef, {'quantity': quantity - 1});
      transaction.update(catRef, {
        'hungry': newSatiety,
        'satietyUpdatedAt': updatedAt.toIso8601String(),
      });
    });
  }
}
