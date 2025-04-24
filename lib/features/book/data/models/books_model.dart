import '../../domain/entities/book.dart';



// class BooksModel extends BooksEntities {
//   const BooksModel({
//     required super.count,
//     required super.next,
//     super.previous,
//     required List<Results> super.results,
//   });
//
//   factory BooksModel.fromJson(Map<String, dynamic> json) {
//     return BooksModel(
//       count: json['count'],
//       next: json['next'],
//       previous: (json['previous'] != null) ? json['previous'] : null,
//       results:
//           List.from(json['results']).map((e) => Results.fromJson(e)).toList(),
//     );
//   }
//
//   @override
//   Map<String, dynamic> toJson() {
//     return {
//       'count': count,
//       'next': next,
//       'previous': previous,
//       'results': results.map((e) => e.toJson()).toList(),
//     };
//   }
// }

class Results extends ResultsEntity {
  const Results({
    required super.id,
    required super.title,
    required List<Authors> super.authors,
    required super.summaries,
    required List<Translators> super.translators,
    required super.subjects,
    required super.bookshelves,
    required super.languages,
    required super.copyright,
    required super.mediaType,
    required Formats super.formats,
    required super.downloadCount,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      id: json['id'],
      title: json['title'],
      authors:
          List.from(json['authors']).map((e) => Authors.fromJson(e)).toList(),
      summaries: List.castFrom<dynamic, String>(json['summaries']),
      translators:
          List.from(
            json['translators'],
          ).map((e) => Translators.fromJson(e)).toList(),
      subjects: List.castFrom<dynamic, String>(json['subjects']),
      bookshelves: List.castFrom<dynamic, String>(json['bookshelves']),
      languages: List.castFrom<dynamic, String>(json['languages']),
      copyright: json['copyright'],
      mediaType: json['media_type'],
      formats: Formats.fromJson(json['formats']),
      downloadCount: json['download_count'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'authors': authors.map((e) => e.toJson()).toList(),
      'summaries': summaries,
      'translators': translators.map((e) => e.toJson()).toList(),
      'subjects': subjects,
      'bookshelves': bookshelves,
      'languages': languages,
      'copyright': copyright,
      'media_type': mediaType,
      'formats': formats.toJson(),
      'download_count': downloadCount,
    };
  }
}

class Authors extends AuthorsEntity {
  const Authors({required super.name, super.birthYear, super.deathYear});

  factory Authors.fromJson(Map<String, dynamic> json) {
    return Authors(
      name: json['name'],
      birthYear: (json['birth_year'] != null) ? json['birth_year'] : 0,
      deathYear: (json['death_year'] != null) ? json['death_year'] : 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'name': name, 'birth_year': birthYear, 'death_year': deathYear};
  }
}

class Translators extends TranslatorsEntity {
  const Translators({required super.name, super.birthYear, super.deathYear});

  factory Translators.fromJson(Map<String, dynamic> json) {
    return Translators(
      name: json['name'],
      birthYear: (json['birth_year'] != null) ? json['birth_year'] : 0,
      deathYear: (json['death_year'] != null) ? json['death_year'] : 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'name': name, 'birth_year': birthYear, 'death_year': deathYear};
  }
}

class Formats extends FormatsEntity {
  const Formats({
    required super.textHtml,
    required super.applicationEpubZip,
    required super.applicationXMobiPocketEbook,
    required super.applicationRdfXml,
    required super.imageJpeg,
    required super.textPlainCharsetUsAscii,
    required super.applicationOctetStream,
  });

  factory Formats.fromJson(Map<String, dynamic> json) {
    return Formats(
      textHtml: json['text/html'],
      applicationEpubZip: json['application/epub+zip'],
      applicationXMobiPocketEbook: json['application/x-mobipocket-ebook'],
      applicationRdfXml: json['application/rdf+xml'],
      imageJpeg: json['image/jpeg'],
      textPlainCharsetUsAscii: json['text/plain; charset=us-ascii'],
      applicationOctetStream: json['application/octet-stream'],
    );
  }
  @override
  Map<String, dynamic> toJson() {

    return {
    'text/html' : textHtml,
   'application/epub+zip' : applicationEpubZip,
    'application/x-mobipocket-ebook' : applicationXMobiPocketEbook,
    'application/rdf+xml' : applicationRdfXml,
    'image/jpeg' : imageJpeg,
    'text/plain; charset=us-ascii' : textPlainCharsetUsAscii,
    'application/octet-stream' : applicationOctetStream,
    };
  }
}
