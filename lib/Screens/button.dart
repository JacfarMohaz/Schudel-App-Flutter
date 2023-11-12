import 'package:flutter/material.dart';
import 'package:production_schedule/constants.dart';

class MyButton extends StatelessWidget {
  final String? label;
  final Function() onTap;

  MyButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: kCardColor),
        child: Center(
          child: Text(
            label!,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

final ButtonStyle ButtonPrimary = ElevatedButton.styleFrom(
  minimumSize: Size(327, 50),
  primary: kSidebarColor,
  elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(50)),
  ),
);
