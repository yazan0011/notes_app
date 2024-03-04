import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubits/note_cubit/note_cubit.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/widgets/add_note_sheet.dart';
import 'package:notes/widgets/custom_button.dart';
import 'package:notes/widgets/custom_textfield.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key, required this.note});
  final NoteModel note;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  String? title, subTilte;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 51,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Edit Note',
                  style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2,
                      fontFamily: 'PlayfairDisplay',
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 46,
            ),
            customTextfield(
              onChanged: (p0) {
                title = p0;
              },
              title: widget.note.title,
              onSaved: (data) {
                title = data;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            customTextfield(
              onChanged: (p0) {
                subTilte = p0;
              },
              onSaved: (data) {
                subTilte = data;
              },
              title: widget.note.subTitle,
              lines: 15,
            ),
            const SizedBox(
              height: 16,
            ),
            EditColorListView(
              note: widget.note,
            ),
            const SizedBox(
              height: 26,
            ),
            CustomBotton(
              title: 'Edit',
              ontap: () {
                widget.note.title = title ?? widget.note.title;
                widget.note.subTitle = subTilte ?? widget.note.subTitle;
                widget.note.save();
                BlocProvider.of<NoteCubit>(context).featchNote();
                Navigator.pop(context);
                var snackBar = SnackBar(
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: '',
                    color: const Color.fromARGB(255, 17, 105, 114),
                    message: '   Note Edited successfully',
                    messageFontSize: 16,
                    contentType: ContentType.success,
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            )
          ],
        ),
      ),
    );
  }
}

class EditColorListView extends StatefulWidget {
  const EditColorListView({super.key, required this.note});
  final NoteModel note;
  @override
  State<EditColorListView> createState() => _ColorListViewState();
}

class _ColorListViewState extends State<EditColorListView> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = colors.indexOf(Color(widget.note.color));
  }

  List<Color> colors = const [
    Color.fromARGB(255, 144, 76, 71),
    Color.fromARGB(255, 153, 143, 72),
    Color(0xffD9E76C),
    Color.fromARGB(255, 73, 127, 148),
    Color.fromARGB(255, 64, 142, 119),
    Color.fromARGB(255, 132, 68, 107),
    Color.fromARGB(255, 119, 139, 75),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38 * 2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              currentIndex = index;
              widget.note.color = colors[index].value;
              setState(() {});
            },
            child: ColorItem(
              color: colors[index],
              isActiv: currentIndex == index,
            ),
          );
        },
      ),
    );
  }
}
