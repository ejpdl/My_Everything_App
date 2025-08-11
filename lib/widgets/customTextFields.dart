import 'package:flutter/material.dart';

import '../widgets/styles.dart';

class CustomTextFields extends StatelessWidget {

  final String label;
  final Color? labelColor;
  final Color? inputColor;
  final TextEditingController controller;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? togglePassword;

const CustomTextFields({ 
  
  super.key,
  required this.label,
  this.labelColor,
  this.inputColor,
  required this.controller,
  this.isPassword = false,
  this.obscureText = false,
  this.togglePassword,

});

  @override
  Widget build(BuildContext context){
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Text(
          label,
          style: TextStyle(
            color: labelColor ?? AppColors.heading,
            fontFamily: 'Montserrat',
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 08.0),

        TextField(
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(
            color: inputColor ?? Colors.black,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            hintText: 'Enter your $label',
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
              fontFamily: 'Inter',
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Color(0xFFE09CAA),
                width: 1.5,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Color(0xFFE09CAA),
                width: 2.0,
              ),
            ),
            suffixIcon: isPassword
              ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off_sharp : Icons.visibility_sharp,
                  color: Colors.grey,
                ),
                onPressed: togglePassword,
              )
              : null,

          ),

        ),

      ],
    
    );
  }
}