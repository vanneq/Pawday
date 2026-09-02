import 'package:flutter/cupertino.dart';
import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/cat/cat_model.dart';
import 'package:kotik/features/main/data/datasource/cats_datasource.dart';
import 'package:kotik/features/main/domain/repository/cat_repository.dart';

class CatRepositoryImpl implements CatRepository {
  final CatsDatasource catsDatasource;

  CatRepositoryImpl({required this.catsDatasource});

  @override
  Future<Result<void>> addCat(String userId, CreateCatParams cat) async {
    try {
      await catsDatasource.addCat(userId, cat);
      return Success(data: null);
    } catch (e) {
      debugPrint(e.toString());
      return Failure<void>('Не удалось добавить кота 😿', e);
    }
  }

  @override
  Stream<Result<List<CatModel>>> watchCats(String userId) async* {
    try {
      await for (final cats in catsDatasource.getCats(userId)) {
        yield Success(data: cats);
      }
    } catch (e) {
      debugPrint(e.toString());
      yield Failure<List<CatModel>>('Не удалось загрузить котов 😿', e);
    }
  }

  @override
  Future<Result<void>> updateCat(String userId, CatModel cat) async {
    try {
      await catsDatasource.editCat(userId, cat);
      return Success(data: null);
    } catch (e) {
      debugPrint(e.toString());
      return Failure<void>('Не удалось обновить кота 😿', e);
    }
  }

  @override
  Future<Result<void>> deleteCat(String userId, String catId) async {
    try {
      await catsDatasource.deleteCat(userId, catId);
      return Success(data: null);
    } catch (e) {
      debugPrint(e.toString());
      return Failure<void>('Не удалось удалить кота 😿', e);
    }
  }
}
