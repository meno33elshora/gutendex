import 'package:equatable/equatable.dart';

// abstract  class BooksEntities extends Equatable {
//   const BooksEntities({
//     required this.count,
//     required this.next,
//     this.previous,
//     required this.results,
//   });
//
//   final int count;
//   final String next;
//   final String? previous;
//   final List<ResultsEntity> results;
//
//   Map<String, dynamic> toJson();
//   @override
//   // TODO: implement props
//   List<Object?> get props => [count, next, previous, results];
// }

abstract  class ResultsEntity extends Equatable {
  const ResultsEntity({
    required this.id,
    required this.title,
    required this.authors,
    required this.summaries,
    required this.translators,
    required this.subjects,
    required this.bookshelves,
    required this.languages,
    required this.copyright,
    required this.mediaType,
    required this.formats,
    required this.downloadCount,
  });

  final int id;
  final String title;
  final List<AuthorsEntity> authors;
  final List<String> summaries;
  final List<TranslatorsEntity> translators;
  final List<String> subjects;
  final List<String> bookshelves;
  final List<String> languages;
  final bool? copyright;
  final String mediaType;
  final FormatsEntity formats;
  final int downloadCount;

  Map<String, dynamic> toJson();
  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    title,
    authors,
    summaries,
    translators,
    subjects,
    bookshelves,
    languages,
    copyright,
    mediaType,
    formats,
    downloadCount,
  ];
}

abstract  class AuthorsEntity extends Equatable {
  const AuthorsEntity({required this.name, this.birthYear, this.deathYear});

  final String name;
  final int? birthYear;
  final int? deathYear;
  Map<String, dynamic> toJson();
  @override
  // TODO: implement props
  List<Object?> get props => [name, birthYear, deathYear];
}

abstract  class TranslatorsEntity extends Equatable {
  const TranslatorsEntity({required this.name, this.birthYear, this.deathYear});

  final String name;
  final int? birthYear;
  final int? deathYear;
  Map<String, dynamic> toJson();
  @override
  // TODO: implement props
  List<Object?> get props => [name, birthYear, deathYear];
}

abstract  class FormatsEntity extends Equatable {
  const FormatsEntity({
    required this.textHtml,
    required this.applicationEpubZip,
    required this.applicationXMobiPocketEbook,
    required this.applicationRdfXml,
    required this.imageJpeg,
    required this.textPlainCharsetUsAscii,
    required this.applicationOctetStream,
  });

  final String textHtml;
  final String applicationEpubZip;
  final String applicationXMobiPocketEbook;
  final String applicationRdfXml;
  final String imageJpeg;
  final String textPlainCharsetUsAscii;
  final String applicationOctetStream;
  Map<String, dynamic> toJson();
  @override
  // TODO: implement props
  List<Object?> get props => [
    textHtml,
    applicationEpubZip,
    applicationXMobiPocketEbook,
    applicationRdfXml,
    imageJpeg,
    textPlainCharsetUsAscii,
    applicationOctetStream,
  ];
}
