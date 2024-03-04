import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/const.dart';
import 'package:notes/cubits/note_cubit/note_cubit.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/simple_bloc_observe.dart';
import 'package:notes/views/note_view.dart';

void main() async {
  Bloc.observer = SimpleBlocObserve();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelsAdapter());
  await Hive.openBox<NoteModel>(kNoteBox);
  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NoteCubit(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        routes: {
          NoteView.id: (context) => const NoteView(),
        },
        debugShowCheckedModeBanner: false,
        initialRoute: NoteView.id,
      ),
    );
  }
}
