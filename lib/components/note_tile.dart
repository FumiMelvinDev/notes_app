import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NoteTile extends StatelessWidget {
  final String title;
  final String note;
  Function(BuildContext)? deleteNoteFunction;

  NoteTile({
    super.key,
    required this.title,
    required this.note,
    required this.deleteNoteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteNoteFunction,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ]),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 24,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
