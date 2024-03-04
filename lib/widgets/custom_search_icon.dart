import 'package:flutter/material.dart';

class CustomSearchIcon extends StatelessWidget {
  const CustomSearchIcon({super.key, required this.icon, this.onpress});
  final IconData icon;
  final Function()? onpress;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //       color: Color.fromARGB(255, 108, 108, 108),
          //       blurRadius: 6,
          //       offset: Offset(1, 2),
          //       spreadRadius: 1)
          // ],
          border:
              Border.all(color: const Color.fromARGB(179, 255, 255, 255), width: 2),
          color: const Color.fromARGB(255, 22, 22, 22).withOpacity(.3),
          borderRadius: BorderRadius.circular(16)),
      child: IconButton(
        icon: Icon(
          icon,
          size: 26,
        ),
        onPressed: () => onpress,
      ),
    );
  }
}
