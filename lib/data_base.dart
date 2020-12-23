//import 'package:note/pages/NoteUpdate.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/notes.dart';

class DbHelper {
  //main variable / copy
  static final DbHelper _sqflite = DbHelper.internal();
  factory DbHelper() => _sqflite;
  // 1 constractor
  DbHelper.internal();
  // liberary = import sqflite
  static Database _db;
  Future<Database> createDatabase() async {
    if (_db != null) {
      return _db;
    }
    //define database path / create main table
    String path = join(await getDatabasesPath(), 'training.db');
    _db = await openDatabase(path, version: 2, onCreate: (Database db, int v) {
// create tables
      db.execute(
          "create table notes(id int primary key autoincrement, name varchar(50), content varchar(280), hours int)");
    },
        // in case you want to upgrade database
        onUpgrade: (Database db, int oldV, int newV)async {
      await db.execute('alter table notes add column level varchar(50)');
    });
    return _db;
  }

  // refrance
  Future<int> createNote(Note note) async {
    Database db = await createDatabase();
    // insert requerd map
    return db.insert('notes', note.toMap());
  }

  Future<List> allNotes() async {
    Database db = await createDatabase();
    return db.query('notes');
  }

  // int refres to afected rows
  Future<int> delete(int id) async {
    Database db = await createDatabase();
    return db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  //update
  Future<int> noteUpdate(Note note) async {
    Database db = await createDatabase();
    return await db
        .update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }
}

//onCreate method
// initDb(Database db, int v) {
// // create tables
//   db.execute(
//       'create table notes(id int primary key autoincrement, name varchar(50), content varchar(280), hours int)');
// }
