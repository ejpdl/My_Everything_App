import 'package:flutter/material.dart';

import '../widgets/styles.dart';
import '../widgets/customAppBar.dart';
import '../widgets/customSearchBar.dart';
import '../widgets/customTaskCard.dart';
import '../widgets/customFloatingActionButton.dart';

import '../services/auth_services.dart';

import '../models/TodoModels.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({ Key? key }) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {

  List<ToDoModel> todos = [];

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  Future<void> loadTodos() async {

    try {

      final fetchedTodos = await AuthService.fetchTodos();
      setState(() {
        todos = fetchedTodos;
      });

    } catch (e) {

      print("Error loading todos: $e");

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,

      body: RefreshIndicator(
        onRefresh: loadTodos,
        child: CustomScrollView(

          physics: const AlwaysScrollableScrollPhysics(),
        
          slivers: [
        
            SliverAppBar(
        
              automaticallyImplyLeading: false,
        
              title: custom_Appbar(),
              floating: true,
              expandedHeight: 320.0,
              toolbarHeight: 70.0,
              backgroundColor: AppColors.background,
              flexibleSpace: FlexibleSpaceBar(
                background: custom_ImageAppbar(),
              ),
        
            ),
        
            SliverAppBar(
        
              automaticallyImplyLeading: false,
              title: Center(child: custom_SearchBar(),),
              pinned: true,
              expandedHeight: 100.0,
              toolbarHeight: 100.0,
              backgroundColor: Color(0xFFF6F5F2),
        
            ),
        
            SliverList(
        
              delegate: SliverChildBuilderDelegate(
        
                (context, index) {
        
                  final todo = todos[index];
        
                  return Padding(
        
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        
                    child: custom_TaskCard(
        
                      context: context,
                      todoId: todo.id,
                      title: todo.title,
                      subtitle: todo.description,
                      month: todo.month,
                      day: todo.day,
                      backgroundColor: Color(0xFF8D2162),
                      onDeleted: () => loadTodos(),
        
                    ),
        
                  );
        
                },
        
                childCount: todos.length,
              ),
        
            ),
        
            SliverFillRemaining(
        
              hasScrollBody: false,
              
              child: Center(
        
                child: Padding(
        
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        
                  child: Column(
        
                    mainAxisAlignment: MainAxisAlignment.center,
        
                    children: [
        
                      Image.asset(
                        'assets/images/girl-on-graduation-amico.png',
                        width: 300.0,
                        height: 300.0,
                        fit: BoxFit.cover,
                      ),
        
                      Text(
                        "You've Reached the Bottom!",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 20.0,
                        ),
                      ),
        
                    ],
        
                  ),
        
                ),
        
              ),  
              
            ),
        
          ],
        
        ),
      ),

      floatingActionButton: custom_FloatingActionButton(context),
      
    );
  }
}