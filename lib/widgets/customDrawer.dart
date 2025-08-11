import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/styles.dart';


Widget custom_Drawer(BuildContext context) {

  return Drawer(

    child: ListView(

      padding: EdgeInsets.zero,

      children: [

        Container(

          height: 100.0,
          decoration: BoxDecoration(
            color: AppColors.drawerbackground,
          ),

          child: Stack(

            children: [

              Align(

                alignment: Alignment.centerLeft,

                child: Padding(

                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),

                  child: Text(
                    "I Love You!",
                    style: AppTextStyles.drawerTitle,
                  ),

                ),  

              ),

              Align(

                alignment: Alignment.centerRight,

                child: IconButton(
                  icon: Icon(Icons.close, color: AppColors.defaultcolor),
                  onPressed: () {

                    Navigator.pop(context);

                  }
                ),

              ),

            ],

          ),

        ),

        const SizedBox(height: 10.0),

        ListTile(

          leading: Icon(Icons.account_circle),
          title: Text("Profile"),
          onTap: () {},

        ),

        ListTile(

          leading: Icon(Icons.accessibility_rounded),
          title: Text("My Character"),
          onTap: () {},

        ),

        ListTile(

          leading: Icon(Icons.info_outline_rounded),
          title: Text("About"),
          onTap: () {},

        ),

        const SizedBox(height: 400.0),

        Align(

          alignment: Alignment.center,

          child: SizedBox(
            width: 160.0,
            height: 58.0,

            child: OutlinedButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                elevation: 6,
                backgroundColor: Colors.transparent,
                side: BorderSide(
                  color: Colors.black,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.exit_to_app_rounded,
                      color: Colors.black, size: 20.0),
                  SizedBox(width: 10.0),
                  Text(
                    "Exit",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
        ),

      ],

    ),

  );

}