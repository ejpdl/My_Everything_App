import 'package:flutter/material.dart';

import '../widgets/styles.dart';

import '../pages/dashboard_page.dart';

class custom_Appbar extends StatelessWidget {
const custom_Appbar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Center(

      child: Padding(

        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 70.0),

        child: Row(

          mainAxisAlignment: MainAxisAlignment.start,

          children: [

            IconButton(

              onPressed: () {

                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 1000),
                    pageBuilder: (_, __, ___) => DashboardPage(),
                  ),
                );
              
              },
              icon: Icon(
                Icons.arrow_back,
                size: 30.0,
                color: Colors.black,
              ),

            ),

            SizedBox(width: 20.0),

            Align(

              alignment: Alignment.centerLeft,

              child: Text("To-Do List", style: AppTextStyles.appBarTitles),

            ),

          ],
            
        ),

      ),

    );
  }
}


class custom_ImageAppbar extends StatelessWidget {
const custom_ImageAppbar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Center(

      child: Padding(

        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),

        child: Column(

          children: [

            SizedBox(height: 84.0),

            Hero(

              tag: 'todo-image',

              child: Image.asset(
                'assets/images/To-do-list-amico.png',
                width: 239.0,
                height: 239.0,
                fit: BoxFit.contain,  
              ),

            ),

          ],

        ),

      ),

    );
    
  }
}