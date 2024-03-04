import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:notes/const.dart';
import 'package:notes/cubits/add_note_cubit/add_note_state.dart';
import 'package:notes/models/note_model.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(InitialState());

  Color color = const Color(0xffAC3453);
  addNote(NoteModel note) async {
    note.color = color.value;
    emit(LoadingState());
    try {
      var notesBox = Hive.box<NoteModel>(kNoteBox);
      emit(SuccessState());
      await notesBox.add(note);
    } catch (e) {
      emit(FailureState(e.toString()));
    }
  }
}
