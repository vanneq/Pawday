import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kotik/core/model/cat/cat_model.dart';

class CatsDatasource {
  final FirebaseFirestore firestore;

  CatsDatasource({required this.firestore});

  Future<void> addCat(String userId, CreateCatParams cat) async {
    final docRef = firestore
        .collection('users')
        .doc(userId)
        .collection('cats')
        .doc();

    final createdCat = CatModel(
      id: docRef.id,
      name: cat.name,
      createdAt: cat.createdAt,
      color: cat.color,
      dayWithCat: cat.dayWithCat,
      dairyEntries: cat.dairyEntries,
      character: cat.character,
    );
    return await docRef.set(createdCat.toJson());
  }

  Stream<List<CatModel>> getCats(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('cats')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((cat) => CatModel.fromJson(cat.data()))
              .toList();
        });
  }

  Future<void> deleteCat(String userId, String catId) async {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('cats')
        .doc(catId)
        .delete();
  }

  Future<void> editCat(String userId, CatModel cat) async {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('cats')
        .doc(cat.id)
        .set(cat.toJson(), SetOptions(merge: true));
  }
}
