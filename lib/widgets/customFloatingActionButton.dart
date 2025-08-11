import 'package:flutter/material.dart';

import '../widgets/customDialog.dart';

Widget custom_FloatingActionButton(BuildContext context){

  return Container(

    margin: EdgeInsets.only(bottom: 20.0),

    child: FloatingActionButton.extended(
      onPressed: () {

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {

            return const CustomDialog(title: "Create a New Task");

          }
        );

      },
      label: Text(
        "Add Task",
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins',
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      icon: Icon(
        Icons.edit_document,
        size: 24.0,
        color: Colors.white,
      ),
      backgroundColor: Color(0xFFA75DB4),
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),

  );

}
