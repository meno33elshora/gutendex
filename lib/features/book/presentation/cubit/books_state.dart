part of 'books_cubit.dart';

@immutable
sealed class BooksState extends Equatable {}

final class BooksInitial extends BooksState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


//! Get All Books
class LoadingBooksState extends BooksState {
  @override
  List<Object?> get props => [];
}

class LoadingPageBooksState extends BooksState {
@override
List<Object?> get props => [];
}

class ErrorBooksState extends BooksState {
final String error;

 ErrorBooksState({required this.error});
@override
List<Object> get props => [error];
}

class LoadedBooksState extends BooksState {
final List<ResultsEntity> books;

LoadedBooksState({required this.books});

@override
List<Object> get props => [books];
}


//! Get Books From Search
class LoadingSearchBooksState extends BooksState {
@override
List<Object?> get props => [];
}

class LoadingSearchPageBooksState extends BooksState {
@override
List<Object?> get props => [];
}

class ErrorSearchBooksState extends BooksState {
final String error;

ErrorSearchBooksState({required this.error});
@override
List<Object> get props => [error];
}

class LoadedSearchBooksState extends BooksState {
final List<ResultsEntity> searchBooks;

LoadedSearchBooksState({required this.searchBooks});

@override
List<Object> get props => [searchBooks];
}


