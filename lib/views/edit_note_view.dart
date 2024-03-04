import 'package:flutter/material.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/widgets/edit_note.dart';

class EditNoteView extends StatelessWidget {
  const EditNoteView({super.key, required this.note});
  static const id = 'EditNote';
  final NoteModel note;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditNote(note: note),
    );
  }
}
