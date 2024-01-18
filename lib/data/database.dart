import 'package:hive_flutter/hive_flutter.dart';

class NoteDatabase {
  final _mybox = Hive.box('mybox');

  List notesList = [];

  void createInitialData() {
    notesList = [
      ['Welcome', 'Created by Fumi melvin']
    ];
  }

  // Load data
  void getNotes() {
    notesList = _mybox.get("NOTESLIST");
  }

  // update database
  void updateDatabase() {
    _mybox.put("NOTESLIST", notesList);
  }
}
