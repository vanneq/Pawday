import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:kotik/core/model/diary/diary_model.dart';

class DiaryDatasource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  DiaryDatasource({required this.firestore, required this.storage});

  Future<void> addEntry(
    String userId,
    String catId,
    DiaryParams diaryEntry,
  ) async {
    String? imageUrl;
    if (diaryEntry.imageFile != null) {
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        diaryEntry.imageFile!.path,
        '${diaryEntry.imageFile!.parent.path}/compressed_${diaryEntry.imageFile!.uri.pathSegments.last}',
        quality: 75,
        minWidth: 1080,
        minHeight: 1080,
      );
      final fileToUpload = compressedFile != null
          ? File(compressedFile.path)
          : diaryEntry.imageFile;
      final ref = storage
          .ref()
          .child('diary')
          .child(userId)
          .child(diaryEntry.catId)
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      await ref.putFile(fileToUpload!);
      imageUrl = await ref.getDownloadURL();
    }
    final docRef = firestore
        .collection('users')
        .doc(userId)
        .collection('cats')
        .doc(catId)
        .collection('entries')
        .doc();

    final createdEntry = DiaryModel(
      id: docRef.id,
      catId: catId,
      imageUrl: imageUrl,
      createdAt: diaryEntry.createdAt,
      description: diaryEntry.description,
      mood: diaryEntry.mood,
    );
    return await docRef.set(createdEntry.toJson());
  }

  Stream<List<DiaryModel>> watchDiary(String userId, String catId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('cats')
        .doc(catId)
        .collection('entries')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((diary) => DiaryModel.fromJson(diary.data()))
              .toList();
        });
  }

  Future<void> deleteEntry(String userId, String catId, String entryId) async {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('cats')
        .doc(catId)
        .collection('entries')
        .doc(entryId)
        .delete();
  }

  Future<void> updateEntry(
    String userId,
    String catId,
    DiaryModel diaryEntry,
  ) async {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('cats')
        .doc(catId)
        .collection('entries')
        .doc(diaryEntry.id)
        .set(diaryEntry.toJson(), SetOptions(merge: true));
  }
}
