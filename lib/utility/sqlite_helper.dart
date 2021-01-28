import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  final String nameDatabase = 'parttime.db';
  final String tableDatabase = 'applyTable';
  int version = 1;

  final String idColumn = 'id';
  final String idResumeColumn = 'id_resume';
  final String idJobdescriptionColumn = 'id_jobdescription';

  SQLiteHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $idResumeColumn INTEGER, $idJobdescriptionColumn INTEGER'),
        version: version);
  }
}
