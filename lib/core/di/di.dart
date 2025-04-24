
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gutendex/features/book/domain/usecases/get_book_usecase.dart';
import 'package:gutendex/features/book/domain/usecases/get_books_search_usecase.dart';
import 'package:gutendex/features/book/presentation/cubit/books_cubit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/book/data/data_sources/local_data_sources.dart';
import '../../features/book/data/data_sources/remote_data_sources.dart';
import '../../features/book/data/repositories/repositories.dart';
import '../../features/book/domain/repositories/base_repositories.dart';
import '../network/network.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// features * posts
  // Cubit **
  sl.registerFactory<BooksCubit>(() => BooksCubit(getBooksUseCase: sl(), getBooksSearchUseCase: sl()));

  // UseCase **
  sl.registerLazySingleton<GetBooksUseCase>(() => GetBooksUseCase(sl()));
  sl.registerLazySingleton<GetBooksSearchUseCase>(() => GetBooksSearchUseCase(sl()));

  // Repository **
  sl.registerLazySingleton<BasePostsRepository>(() => BooksRepository(
    booksRemoteDataSource: sl(),
    booksLocalDataSource: sl(),
    networkInfo: sl(),
  ));
  // Data Sources **
  sl.registerLazySingleton<BooksRemoteDataSource>(
          () => BooksRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<BooksLocalDataSource>(
          () => BooksLocalDataSourceImpl(sharedPreferences: sl()));

  /// Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// External
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<InternetConnectionChecker>(
        () => InternetConnectionChecker(),
  );
}
