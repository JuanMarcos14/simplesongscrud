import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:simplecrudctej/models/songs_class.dart';

class SongsDatabase {
  static final SongsDatabase instance = SongsDatabase._init();

  static Database? _database;

  SongsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('songs.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE $tableSongs (
      ${SongFields.id} $idType,
      ${SongFields.title} $textType,
      ${SongFields.artists} $textType,
      ${SongFields.duration} $integerType
    )
    ''');
  }

  Future<Song> create(Song song) async {
    final db = await instance.database;

    final id = await db.insert(tableSongs, song.toJson());
    return song.copy(id: id);
  }

  Future<Song?> readSong(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableSongs,
      columns: SongFields.values,
      where: '${SongFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Song.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Song>> readAllSong() async {
    final db = await instance.database;

    final results = await db.query(tableSongs);

    return results.map((json) => Song.fromJson(json)).toList();
  }

  Future<int> update(Song song) async {
    final db = await instance.database;

    return db.update(
      tableSongs,
      song.toJson(),
      where: '${SongFields.id} = ?',
      whereArgs: [song.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableSongs,
      where: '${SongFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    if (db.isOpen) {
      db.close();
    }
  }
}
