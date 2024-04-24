final String tableMovies = 'movies';

class MovieFields {
  static final List<String> values = [
    id, isFavorite, rating, title, description, time
  ];

  static final String id = '_id';
  static final String isFavorite = 'isFavorite';
  // static final String filepath = 'filepath';
  static final String rating = 'rating';
  static final String title = 'title';
  static const String description = 'description';
  static final String time = 'time';
}

class Movie {
  final int? id;
  // final String filepath;
  final bool isFavorite;
  final int rating;
  final String title;
  final String description;
  final DateTime createdTime;

  const Movie({
    this.id,
    required this.isFavorite,
    // required this.filepath,
    required this.rating,
    required this.title,
    required this.description,
    required this.createdTime
  });

  Movie copy({
    int? id,
    bool? isFavorite,
    // String? filepath,
    int? rating,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Movie(
        id: id ?? this.id,
        isFavorite: isFavorite ?? this.isFavorite,
        // filepath: filepath ?? this.filepath,
        rating: rating ?? this.rating,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static Movie fromJson(Map<String, Object?> json) => Movie(
    id: json[MovieFields.id] as int?,
    isFavorite: json[MovieFields.isFavorite] == 1,
    // filepath: json[MovieFields.filepath] as String,
    rating: json[MovieFields.rating] as int,
    title: json[MovieFields.title] as String,
    description: json[MovieFields.description] as String,
    createdTime: DateTime.parse(json[MovieFields.time] as String),
  );

  Map<String, Object?> toJson() => {
    MovieFields.id: id,
    MovieFields.title: title,
    // MovieFields.filepath: filepath,
    MovieFields.isFavorite: isFavorite ? 1 : 0,
    MovieFields.rating: rating,
    MovieFields.description: description,
    MovieFields.time: createdTime.toIso8601String(),
  };
}