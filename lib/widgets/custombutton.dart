import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;
  const Custombutton({
    super.key, required this.text, required this.color, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Center(child: Text(text,style: TextStyle(fontSize: 20,color: Colors.white),),),
    
      ),
    );
  }
}
