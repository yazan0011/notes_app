import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/const.dart';
import 'package:notes/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notes/cubits/add_note_cubit/add_note_state.dart';
import 'package:notes/cubits/note_cubit/note_cubit.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/widgets/custom_button.dart';
import 'package:notes/widgets/custom_textfield.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:intl/intl.dart';

class AddNoteSheet extends StatefulWidget {
  const AddNoteSheet({super.key});

  @override
  State<AddNoteSheet> createState() => _AddNoteSheetState();
}

class _AddNoteSheetState extends State<AddNoteSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? title, subTilte;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNoteCubit(),
      child: BlocConsumer<AddNoteCubit, AddNoteState>(
        listener: (context, state) {
          if (state is SuccessState) {
            var snackBar = SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: '',
                color: const Color.fromARGB(255, 20, 95, 23),
                message: '   Note added successfully',
                messageFontSize: 16,
                contentType: ContentType.success,
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            BlocProvider.of<NoteCubit>(context).featchNote();
            Navigator.pop(context);
          }
          if (state is FailureState) {
            const SnackBar(content: Text('Something Went Wrong'));
          }
        },
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state is LoadingState ? true : false,
            child: Padding(
              padding: EdgeInsets.only(
                  right: 16,
                  left: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  autovalidateMode: autovalidateMode,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        'New Note',
                        style: TextStyle(
                          wordSpacing: 2,
                          letterSpacing: 4,
                          fontSize: 20,
                          fontFamily: 'PlayfairDisplay',
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      customTextfield(
                        onSaved: (value) {
                          title = value;
                        },
                        title: 'Title',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      customTextfield(
                        onSaved: (value) {
                          subTilte = value;
                        },
                        title: 'Content',
                        lines: 8,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const ColorListView(),
                      const SizedBox(
                        height: 16,
                      ),
                      BlocBuilder<AddNoteCubit, AddNoteState>(
                        builder: (context, state) {
                          return CustomBotton(
                            isLoading: state is LoadingState ? true : false,
                            title: 'Add',
                            ontap: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();

                                var currentDate = DateTime.now();
                                var formattedDate =
                                    DateFormat.yMEd().format(currentDate);
                                var noteModel = NoteModel(
                                    title: title!,
                                    subTitle: subTilte!,
                                    date: formattedDate,
                                    color: Colors.blueAccent.value);

                                BlocProvider.of<AddNoteCubit>(context)
                                    .addNote(noteModel);
                              } else {
                                autovalidateMode = AutovalidateMode.always;
                                setState(() {});
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ColorItem extends StatelessWidget {
  const ColorItem({super.key, required this.isActiv, required this.color});
  final bool isActiv;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return isActiv
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 221, 221, 221),
              radius: 38,
              child: CircleAvatar(
                radius: 35,
                backgroundColor: color,
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: CircleAvatar(
              radius: 36,
              backgroundColor: color,
            ),
          );
  }
}

class ColorListView extends StatefulWidget {
  const ColorListView({super.key});

  @override
  State<ColorListView> createState() => _ColorListViewState();
}

class _ColorListViewState extends State<ColorListView> {
  int currentIndex = 0;
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
              BlocProvider.of<AddNoteCubit>(context).color = colors[index];
              currentIndex = index;
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
