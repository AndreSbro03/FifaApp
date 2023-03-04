import 'package:flutter_application_2/dati/Players.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PlayersDatabase {
  static final PlayersDatabase instance = PlayersDatabase._init();

  static Database? _database;

  PlayersDatabase._init();

  Future<Database> get database async {
    print('sono in getdatabase');
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
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tablePlayers ( 
  ${PlayerFields.id} $idType, 
  ${PlayerFields.image} $textType,
  ${PlayerFields.name} $textType,
  ${PlayerFields.color} $integerType
  )
''');
  }

  Future<Player> createPlayer(Player player) async {
    final db = await instance.database;

    final id = await db.insert(tablePlayers, player.toJson());
    return player.copy(id: id);
  }

  Future<Player> readPlayer(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tablePlayers,
      columns: PlayerFields.values,
      where: '${PlayerFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Player.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Player>> readAllPlayers() async {
    final db = await instance.database;

    final result = await db.query(tablePlayers);

    return result.map((json) => Player.fromJson(json)).toList();
  }

  Future<int> updatePlayer(Player player) async {
    final db = await instance.database;

    return db.update(
      tablePlayers,
      player.toJson(),
      where: '${PlayerFields.id} = ?',
      whereArgs: [player.id],
    );
  }

  Future<int> deletePlayer(int id) async {
    final db = await instance.database;

    return await db.delete(
      tablePlayers,
      where: '${PlayerFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  Future drop() async {
    final db = await instance.database;

    db.delete('players');
  }
}
