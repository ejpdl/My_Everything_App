import 'package:flutter/material.dart';

import '../widgets/styles.dart';

Widget custom_SearchBar(){

  return Container(

    width: 270,

    child: TextField(
      decoration: InputDecoration(
        hintText: "Find Something...",
        hintStyle: TextStyle(
          color: AppColors.heading,
          fontSize: 15.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          letterSpacing: 1.0,
        ),
        prefixIcon: Icon(
          Icons.search_outlined,
          color: Colors.black,
          size: 25.0,
        ),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide(
            color: Color(0xFFA75DB4),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide(
            color: Color.fromRGBO(192, 50, 78, 1),
            width: 1.5,
          ),
        ),
      ),
    ),

  );

}