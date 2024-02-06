
import 'package:flutter/material.dart';
import 'package:linkbus/core/app_export.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  double opacity ;
   ButtonWidget({required this.onPressed, required this.text,this.opacity = 1.0,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color:theme.primaryColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
