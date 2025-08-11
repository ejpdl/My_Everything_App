import 'package:flutter/material.dart';

import '../pages/todo_page.dart';

import '../widgets/customDrawer.dart';
import '../widgets/customSearchBar.dart';
import '../widgets/styles.dart';

import '../services/character_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({ Key? key }) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); 

  String? imagePath;
  String? firstName;

  @override
  void initState() {

    super.initState();
    loadCharacter();

  }

  void loadCharacter() async {

    final character = await CharacterService.getCharacter();

    if(character != null){

      setState(() {

        imagePath = character['image'];
        firstName = character['first_name'];

      });

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,

      drawer: custom_Drawer(context),

      body: SingleChildScrollView(

        child: Center(

          child: Padding(

            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 70.0),

            child: Column(

              children: [

                Row(

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                        size: 30.0,
                      ),
                    ),

                    SizedBox(width: 20.0),

                    custom_SearchBar(),
                      
                  ],

                ),

                SizedBox(height: 50.0),

                if (imagePath != null)

                  Image.asset(
                    imagePath!,
                    width: 239.0,
                    height: 239.0,
                    fit: BoxFit.contain,
                  )

                else
                  CircularProgressIndicator(),
                

                custom_Header("Hello, ", firstName ?? '...'),

                SizedBox(height: 30.0),

                Wrap(

                  children: [

                    GestureDetectorCards(
                      icon: Icons.checklist, 
                      imagePath: 'assets/images/To-do-list-amico.png', 
                      title: "To-Do List", 
                      heroTag: 'todo-image', 
                      destinationPage: TodoPage(),
                      backgroundColor: Color(0xFFF3D0D7),
                    ),

                  ],

                ),

              ],

            ),

          ),

        ),

      ),

    );
  }
}