abstract class AddNoteState {}

class InitialState extends AddNoteState {}

class LoadingState extends AddNoteState {}

class SuccessState extends AddNoteState {}

class FailureState extends AddNoteState {
  final String message;

  FailureState(this.message);
}
