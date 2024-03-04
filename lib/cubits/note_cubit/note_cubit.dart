import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:notes/const.dart';
import 'package:notes/cubits/note_cubit/note_state.dart';
import 'package:notes/models/note_model.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitialState());

  List<NoteModel>? notes;
  featchNote() {
    var notesBox = Hive.box<NoteModel>(kNoteBox);
    notes = notesBox.values.toList();
    emit(NoteSuccessState());
  }
}
