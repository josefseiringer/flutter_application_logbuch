import 'package:sqflite/sqflite.dart';
import '../../pages/log/log_model.dart';

class LogsDatabase {
  static const String _databaseName = 'logs.db';
  static const int _databaseVersion = 2;

  static Database? _database;

  static Future<Database?> get database async {
    _database ??= await openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
    return _database;
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE logs ('
        'mnLogId INTEGER PRIMARY KEY AUTOINCREMENT,'
        'szCarModel TEXT,'
        'jdStartDate DATE,'
        'jdEndDate DATE,'
        'mnDistanz DOUBLE,'
        'szRoute TEXT,'
        'szNotiz TEXT,'
        'crateAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP'
        ')');
  }

  //List all Logs
  static Future<List<LogModel>> getAllLogs() async {
    final db = await database;
    final logs = await db!.query('logs');
    return logs.map((log) => LogModel.fromMap(log)).toList();
  }

  //Get Log by Id
  static Future<LogModel?> getLogById(int mnLogId) async {
    final db = await database;
    final log =
        await db!.query('logs', where: 'mnLogId = ?', whereArgs: [mnLogId]);
    return log.isEmpty ? null : LogModel.fromMap(log.first);
  }

  //Insert Log
  static Future<int> insertLog(LogModel log) async {
    final db = await database;
    return await db!.insert('logs', log.toMap());
  }

  //Update Log
  static Future<int> updateLog(LogModel log) async {
    final db = await database;
    return await db!.update('logs', log.toMap(),
        where: 'mnlogId = ?', whereArgs: [log.mnLogId]);
  }

  //Delete Log
  static Future<int> deleteLog(int mnLogId) async {
    final db = await database;
    return await db!.delete('logs', where: 'mnLogId = ?', whereArgs: [mnLogId]);
  }
}
