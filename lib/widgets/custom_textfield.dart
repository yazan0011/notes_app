import 'package:flutter/material.dart';
import 'package:notes/const.dart';

// ignore: camel_case_types
class customTextfield extends StatelessWidget {
  const customTextfield(
      {super.key,
      required this.title,
      this.lines = 1,
      this.onSaved,
      this.onChanged});
  final String title;
  final int lines;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      onChanged: onChanged,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'This field is requierd';
        } else {
          return null;
        }
      },
      cursorColor: kPrimaryColor,
      maxLines: lines,
      decoration: InputDecoration(
        hintText: title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 207, 206, 206), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: kPrimaryColor, width: 2),
        ),
      ),
    );
  }
}
