import 'package:flutter/material.dart';

class CustomButtons extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color backgroundColor;
  final double fontSize;
  final double height;

const CustomButtons({ 
  
  Key? key,
  required this.text,
  required this.onPressed,
  required this.color,
  this.backgroundColor = const Color(0xFFE09CAA),
  this.fontSize = 20.0,
  this.height = 56.0, 

}) : super(key: key);

  @override
  Widget build(BuildContext context){

    return SizedBox(

      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 7.0,
          backgroundColor: backgroundColor,
          minimumSize: Size(348.0, 56.0),
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: fontSize,
          ),
        ),
      ),

    );
  }
}