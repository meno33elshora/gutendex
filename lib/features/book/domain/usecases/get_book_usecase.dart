import 'package:dartz/dartz.dart';
import 'package:gutendex/core/error/failure.dart';
import 'package:gutendex/features/book/domain/entities/book.dart';

import '../repositories/base_repositories.dart';

class GetBooksUseCase {
  final BasePostsRepository basePostsRepository;

  GetBooksUseCase(this.basePostsRepository);

  Future<Either<Failure, List<ResultsEntity>>> call({required int page}) async {
    return await basePostsRepository.getBooks(page: page);
  }
}
