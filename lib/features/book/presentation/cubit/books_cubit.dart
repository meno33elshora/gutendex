import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutendex/core/error/failure.dart';
import 'package:gutendex/core/resources/string_manager.dart';
import 'package:gutendex/features/book/domain/entities/book.dart';
import 'package:gutendex/features/book/domain/usecases/get_book_usecase.dart';
import 'package:gutendex/features/book/domain/usecases/get_books_search_usecase.dart';

part 'books_state.dart';

class BooksCubit extends Cubit<BooksState> {
  final GetBooksUseCase getBooksUseCase;
  final GetBooksSearchUseCase getBooksSearchUseCase;

  BooksCubit({required this.getBooksUseCase, required this.getBooksSearchUseCase}) : super(BooksInitial());

  final List<ResultsEntity> _books = [];
  final List<ResultsEntity> _booksFromSearch = [];
  int _page = 1;
  int _pageSearch = 1;
  List<ResultsEntity> get listOfBooks => _books;
  List<ResultsEntity> get listOfBooksFromSearch => _booksFromSearch;



  Future<void> getBooks({bool hasMaxReached = false}) async {
    if (hasMaxReached) {
      emit(LoadingPageBooksState());
    } else {
      emit(LoadingBooksState());
    }

    final getBooks = await getBooksUseCase(page: _page);
    getBooks.fold(
      (l) {
        emit(ErrorBooksState(error: _mapFailureToError(l)));
      },
      (r) {
        if (r.isNotEmpty) {
          _page++;
          _books.addAll(r);
        }

        emit(LoadedBooksState(books: _books));
      },
    );
  }

  Future<void> getBooksFromSearch({bool hasMaxReached = false ,
    required String input}) async {
    if (hasMaxReached) {
      emit(LoadingSearchPageBooksState());
    } else {
      _booksFromSearch.clear();
      emit(LoadingSearchBooksState());
    }

    final getBooksSearch = await getBooksSearchUseCase(page: _pageSearch,input: input );
    getBooksSearch.fold(
          (l) {
        emit(ErrorSearchBooksState(error: _mapFailureToError(l)));
      },
          (r) {
        if (r.isNotEmpty) {
          _pageSearch++;
          _booksFromSearch.addAll(r);
        }

        emit(LoadedSearchBooksState(searchBooks: _booksFromSearch));
      },
    );
  }
  String _mapFailureToError(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return StringsManager.serverError;
      case EmptyCacheFailure _:
        return StringsManager.emptyCacheError;
      case OfflineFailure _:
        return StringsManager.offlineError;
      default:
        return "Un Expected Error , Please Try Again Later";
    }
  }
}
