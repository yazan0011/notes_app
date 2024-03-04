import 'package:flutter/material.dart';
import 'package:notes/const.dart';

class CustomBotton extends StatelessWidget {
  const CustomBotton(
      {super.key, required this.title, this.ontap, this.isLoading = false});
  final String title;
  final Function()? ontap;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color.fromARGB(255, 143, 143, 143),
            Color.fromARGB(255, 221, 221, 221),
            Color.fromARGB(255, 221, 221, 221),
            Color.fromARGB(255, 143, 143, 143),
          ]),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 19, 19, 19),
                blurRadius: 6,
                offset: Offset(1, 2),
                spreadRadius: 1)
          ],
          // border:
          //     Border.all(color: Color.fromARGB(179, 247, 247, 247), width: 2),
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                )
              : Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlayfairDisplay',
                  ),
                ),
        ),
      ),
    );
  }
}
