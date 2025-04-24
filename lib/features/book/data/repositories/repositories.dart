import 'package:dartz/dartz.dart' ;
import 'package:gutendex/core/network/network.dart';
import 'package:gutendex/features/book/data/data_sources/local_data_sources.dart' ;
import 'package:gutendex/features/book/data/data_sources/remote_data_sources.dart' ;
import 'package:gutendex/features/book/domain/entities/book.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/base_repositories.dart';

typedef Methods = Future<Unit> Function();

class BooksRepository implements BasePostsRepository {
  final BooksRemoteDataSource booksRemoteDataSource;
  final BooksLocalDataSource booksLocalDataSource;
  final NetworkInfo networkInfo;

  BooksRepository({
    required this.booksRemoteDataSource,
    required this.booksLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ResultsEntity>>> getBooks({required int page}) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await booksRemoteDataSource.getAllBooks(page: page);
        booksLocalDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await booksLocalDataSource.getCacheBooks();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<ResultsEntity>>> getBooksSearch({required int page, required String input}) async{
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await booksRemoteDataSource.getAllBooksSearch(page: page, input: input);
        booksLocalDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await booksLocalDataSource.getCacheBooks();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}