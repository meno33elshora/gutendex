import 'package:gutendex/core/api/end_point.dart';
import 'package:gutendex/features/book/data/models/books_model.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/exception.dart';

abstract class BooksRemoteDataSource {
  Future<List<Results>> getAllBooks({required int page});

  Future<List<Results>> getAllBooksSearch({
    required int page,
    required String input,
  });
}

class BooksRemoteDataSourceImpl implements BooksRemoteDataSource {
  final Dio dio;

  BooksRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<Results>> getAllBooks({required int page}) async {
    dio.options.headers = {"Content-Type": "application/json"};
    dio.options.queryParameters = {"pages": page};
    final response = await dio.get("${EndPoint.baseUrl}/books/");
    if (response.statusCode == 200) {
      final List decodeJson = response.data["results"];
      final List<Results> booksModels =
          decodeJson
              .map<Results>(
                (jsonBooksModel) => Results.fromJson(jsonBooksModel),
              )
              .toList();
      return booksModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Results>> getAllBooksSearch({
    required int page,
    required String input,
  }) async {
    dio.options.headers = {"Content-Type": "application/json"};
    dio.options.queryParameters = {"Search": input, "pages": page};
    final response = await dio.get("${EndPoint.baseUrl}/books/");
    if (response.statusCode == 200) {
      final List decodeJson = response.data["results"];
      final List<Results> booksModels =
          decodeJson
              .map<Results>(
                (jsonBooksModel) => Results.fromJson(jsonBooksModel),
              )
              .toList();
      return booksModels;
    } else {
      throw ServerException();
    }
  }
}
