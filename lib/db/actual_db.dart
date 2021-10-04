import 'package:sqflite/sqflite.dart';
import 'package:virtual_card_scanner/models/contact_model.dart';
import 'package:path/path.dart' as path;

class DBSqlite{
  static final String _creteTableContact = '''create table $tableContact(
  $colContactId integer primary key,
  $colContactName text not null,
  $colContactAddress text not null,
  $colContactCompany text not null,
  $colContactDesignation text not null,
  $colContactPhone text not null,
  $colContactEmail text not null,
  $colContactWeb text not null
  )''';

   static Future<Database> _open() async{
    final rootPath = await getDatabasesPath();
    final dbPath = path.join(rootPath, 'contact.db');
    return openDatabase(dbPath,version: 1,
        onCreate: (db, version) async{
      await db.execute(_creteTableContact);
    });
  }

  static Future<int> insertNewContact(ContactModel contactModel) async{
    final db = await _open();
    return db.insert(tableContact, contactModel.toMap());
  }

  static Future<List<ContactModel>> getAllContact() async{
     final db = await _open();
     final mapList = await db.query(tableContact);
     return List.generate(mapList.length, (i) => ContactModel.fromMap(mapList[i]));

  }
  static Future<ContactModel> getContactByRowId(int id) async{
    final db = await _open();
    final mapList = await db.query(tableContact, where: '$colContactId = ?', whereArgs: [id]);
    return ContactModel.fromMap(mapList.first);

  }

  static Future<int> deleteContact(int id) async{
    final db = await _open();
    return db.delete(tableContact,where: '$colContactId = ?', whereArgs: [id]);

  }



}