import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:midterm_exam/model/movies.dart';

class MoviesDatabase {
  static final MoviesDatabase instance = MoviesDatabase._init();

  static Database? _database;

  MoviesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final intType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableMovies(
    ${MovieFields.id} $idType,
    ${MovieFields.isFavorite} $boolType,
    ${MovieFields.rating} $intType,
    ${MovieFields.title} $textType,
    ${MovieFields.description} $textType,
    ${MovieFields.time} $textType
    )
    ''');
  }

  Future<Movie> create(Movie movie) async {
    final db = await instance.database;

    final id = await db.insert(tableMovies, movie.toJson());

    return movie.copy(id: id);
  }

  Future<Movie> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
        tableMovies,
        columns: MovieFields.values,
        where: '${MovieFields.id} = ?',
        whereArgs: [id]
    );

    if (maps.isNotEmpty) {
      return Movie.fromJson(maps.first);
    } else {
      throw Exception('ID $id is not found!');
    }
  }

  Future<List<Movie>> readAll() async {
    final db = await instance.database;

    final orderBy = '${MovieFields.time} ASC';

    final result = await db.query(tableMovies, orderBy: orderBy);

    return result.map((json) => Movie.fromJson(json)).toList();
  }

  Future<int> update(Movie movie) async {
    final db = await instance.database;

    return db.update(
      tableMovies,
      movie.toJson(),
      where: '${MovieFields.id} = ?',
      whereArgs: [movie.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
        tableMovies,
        where: '${MovieFields.id} = ?',
        whereArgs: [id]
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}