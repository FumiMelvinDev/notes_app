import 'package:flutter/material.dart';
import 'package:notes_app/utils/colors.dart';

class NewNote extends StatelessWidget {
  final titleController;
  final noteController;
  VoidCallback saveNote;

  NewNote(
      {super.key,
      this.titleController,
      this.noteController,
      required this.saveNote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            backgroundColor: AppColors.background,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                onPressed: saveNote,
                icon: const Icon(
                  Icons.save,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            child: SliverList(
                delegate: SliverChildListDelegate(
              [
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: titleController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: "Nunito",
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      fontSize: 35,
                      color: Colors.white60,
                      fontFamily: "Nunito",
                    ),
                    border: InputBorder.none,
                  ),
                ),
                TextField(
                  controller: noteController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: "Nunito",
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Type something...',
                    hintStyle: TextStyle(
                      fontSize: 24,
                      color: Colors.white60,
                      fontFamily: "Nunito",
                    ),
                    border: InputBorder.none,
                  ),
                )
              ],
            )),
          )
        ],
      ),
    );
  }
}
