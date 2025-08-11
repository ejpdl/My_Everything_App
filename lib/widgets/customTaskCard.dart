import 'package:flutter/material.dart';

import '../widgets/customDialog.dart';

import '../models/TodoModels.dart';

Widget custom_TaskCard({

  required BuildContext context,
  required int todoId,
  required String title,
  required String subtitle,
  required String month,
  required String day,
  required Color backgroundColor,
  required VoidCallback onDeleted,

}) {

  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 26.0),
            width: 220.0,
            height: 75.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(4, 4),
                ),
              ],
            ),
            child: Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 50.0, top: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Tooltip(
                        message: title,
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontFamily: 'Poppins',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ),
                    SizedBox(height: 5.0),
                    Flexible(
                      child: Tooltip(
                        message: subtitle,
                        child: Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black45.withOpacity(0.9),
                            fontFamily: 'Poppins',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: Container(
              width: 70.0,
              height: 75.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    month,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    day,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      SizedBox(width: 02.0),
      IconButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return CustomDialog(title: "Edit your Task");
              },
            );
          },
          icon: Icon(
            Icons.edit_document,
            color: Color(0xFF8D2162),
            size: 25.0,
          )),
      IconButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => DeleteDialog(
                todoId: todoId,
                onDeleted: onDeleted,
              )
            );
          },
          icon: Icon(
            Icons.delete_rounded,
            color: Color(0xFF8D2122),
            size: 25.0,
          )),
    ],
  );
}