import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:gutendex/features/book/data/models/books_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';

abstract class BooksLocalDataSource {
  Future<List<Results>> getCacheBooks();

  Future<Unit> cachePosts(List<Results> postModel);
}

const String key = "Cache_Books";

class BooksLocalDataSourceImpl implements BooksLocalDataSource {
  final SharedPreferences sharedPreferences;

  BooksLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<Results> booksModel) {
    List postModelToJson = booksModel
        .map<Map<String, dynamic>>((booksModel) => booksModel.toJson())
        .toList();
    sharedPreferences.setString(key, jsonEncode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<Results>> getCacheBooks() {
    final jsonString = sharedPreferences.get(key);
    if (jsonString != null) {
      List decodeJson = json.decode("$jsonString");
      List<Results> jsonToPostModel = decodeJson
          .map<Results>(
              (jsonPostModel) => Results.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModel);
    } else {
      throw EmptyCacheException();
    }
  }
}
