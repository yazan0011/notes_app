import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubits/note_cubit/note_cubit.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/views/edit_note_view.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({super.key, required this.note});
  final NoteModel note;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return EditNoteView(note: note);
            },
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 186, 186, 186),
                  blurRadius: 5,
                  offset: Offset(3, 2),
                  spreadRadius: 0.1)
            ],
            // border:
            //     Border.all(color: Color.fromARGB(179, 196, 196, 196), width: 2),
            color: Color(note.color),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(24),
              bottomLeft: Radius.circular(80),
              topLeft: Radius.circular(24),
              topRight: Radius.circular(80),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ListTile(
                title: Text(
                  note.title,
                  style: const TextStyle(
                    wordSpacing: 1,
                    letterSpacing: 1,
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'PlayfairDisplay',
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Text(
                    note.subTitle,
                    style: TextStyle(
                      wordSpacing: 1,
                      letterSpacing: 1,
                      fontFamily: 'PlayfairDisplay',
                      color: Colors.black.withOpacity(.9),
                      fontSize: 18,
                    ),
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    var snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        color: const Color.fromARGB(255, 33, 92, 194),
                        title: '',
                        message: '   Note deleted successfully',
                        messageFontSize: 16,
                        contentType: ContentType.success,
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    note.delete();
                    BlocProvider.of<NoteCubit>(context).featchNote();
                  },
                ),
              ),
              Text(
                note.date,
                style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  color: Colors.black.withOpacity(.9),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
