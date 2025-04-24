

import 'package:dartz/dartz.dart';
import 'package:gutendex/core/error/failure.dart' show Failure;
import 'package:gutendex/features/book/domain/entities/book.dart';

abstract class BasePostsRepository {
  Future<Either<Failure, List<ResultsEntity>>> getBooks({required int page});
  Future<Either<Failure, List<ResultsEntity>>> getBooksSearch({required int page, required String input});
}