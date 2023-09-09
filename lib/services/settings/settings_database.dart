import 'package:sqflite/sqflite.dart';
import '../../pages/settings/settings_model.dart';

class SettingsDatabase {
  static const String _databaseName = 'settings.db';
  static const int _databaseVersion = 1;

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
    await db.execute('CREATE TABLE settings ('
        'mnSettingId INTEGER PRIMARY KEY AUTOINCREMENT,'
        'szFullName TEXT,'
        'szStreet TEXT,'
        'szPostalCity TEXT,'
        'mnMaxRangeYear DOUBLE '
        'crateAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP'
        ')');
  }

  //List all Settings
  static Future<List<SettingsModel>> getAllSettings() async {
    final db = await database;
    final settings = await db!.query('settings');
    return settings.map((set) => SettingsModel.fromMap(set)).toList();
  }

  //Get Settings by Id
  static Future<SettingsModel?> getSettingsById(int currentSettings) async {
    final db = await database;
    final settings = await db!.query('settings',
        where: 'mnSettingId = ?', whereArgs: [currentSettings]);
    return settings.isEmpty ? null : SettingsModel.fromMap(settings.first);
  }

  //Insert Settings
  static Future<int> insertSettings(SettingsModel setting) async {
    final db = await database;
    return await db!.insert('settings', setting.toMap());
  }

  //Update Settings
  static Future<int> updateSettings(SettingsModel setting) async {
    final db = await database;
    return await db!.update('settings', setting.toMap(),
        where: 'mnSettingId = ?', whereArgs: [setting.mnSettingId]);
  }

  //Delete Settings
  static Future<int> deleteSettings(int settingId) async {
    final db = await database;
    return await db!
        .delete('settings', where: 'mnSettingId = ?', whereArgs: [settingId]);
  }
}
