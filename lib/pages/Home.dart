import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/components/newNote.dart';
import 'package:notes_app/components/note.dart';
import 'package:notes_app/data/database.dart';
import 'package:notes_app/utils/colors.dart';
import 'package:notes_app/components/note_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  NoteDatabase db = NoteDatabase();

  final _myBox = Hive.box('mybox');

  @override
  void initState() {
    if (_myBox.get("NOTESLIST") == null) {
      // create default data
      db.createInitialData();
    } else {
      // user data exist
      db.getNotes();
    }

    super.initState();
  }

  // save new note
  void saveNewNote() {
    setState(
      () {
        db.notesList.add(
          [_titleController.text, _noteController.text],
        );
        _titleController.clear();
        _noteController.clear();
      },
    );
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // delete note
  void deleteNote(int index) {
    setState(() {
      db.notesList.removeAt(index);
    });
    db.updateDatabase();
  }

  void addNewNote() {
    showDialog(
        context: context,
        builder: (context) {
          return NewNote(
            titleController: _titleController,
            noteController: _noteController,
            saveNote: saveNewNote,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Notes',
          style: TextStyle(
            fontSize: 43,
            fontWeight: FontWeight.w600,
            fontFamily: 'Nunito',
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.iconBox,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.iconBox,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewNote,
        backgroundColor: AppColors.iconBox,
        shape: const CircleBorder(eccentricity: 0),
        child: const Icon(
          Icons.add,
          size: 32,
          color: Colors.white,
        ),
      ),
      backgroundColor: AppColors.background,
      body: ListView.builder(
        itemCount: db.notesList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Note(
                    title: db.notesList[index][0],
                    note: db.notesList[index][1],
                  ),
                ),
              );
            },
            child: NoteTile(
              title: db.notesList[index][0],
              note: db.notesList[index][1],
              deleteNoteFunction: (context) {
                deleteNote(index);
              },
            ),
          );
        },
      ),
    );
  }
}
