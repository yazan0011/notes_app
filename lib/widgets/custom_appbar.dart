// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notes/widgets/add_note_sheet.dart';
import 'package:notes/widgets/custom_search_icon.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Notes',
          style: TextStyle(
            letterSpacing: 3,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'PlayfairDisplay',
          ),
        ),
        const Spacer(),
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromARGB(179, 255, 255, 255), width: 2),
              color: Colors.black.withOpacity(.3),
              borderRadius: BorderRadius.circular(16)),
          child: IconButton(
            icon: const Icon(
              Icons.add,
              size: 26,
            ),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                context: context,
                builder: (context) {
                  return const AddNoteSheet();
                },
              );
            },
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        const CustomSearchIcon(
          icon: Icons.search,
        ),
      ],
    );
  }
}
