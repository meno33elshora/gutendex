
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/book.dart';
import '../repositories/base_repositories.dart';

class GetBooksSearchUseCase {
  final BasePostsRepository basePostsRepository;

  GetBooksSearchUseCase(this.basePostsRepository);

  Future<Either<Failure, List<ResultsEntity>>> call({required int page , required String input}) async {
    return await basePostsRepository.getBooksSearch(page: page, input: input);
  }
}
