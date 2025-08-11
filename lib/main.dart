import 'package:flutter/material.dart';

import 'pages/get_started_page.dart';
import 'pages/landing_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/character_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/todo_page.dart';

void main() => runApp(MaterialApp(

  debugShowCheckedModeBanner: false,
  
  initialRoute: '/',

  routes: {

    '/': (context) => const GetStartedPage(),
    '/landing_page': (context) => const LandingPage(),
    '/login_page': (context) => const LogInPage(),
    '/register_page': (context) => const RegisterPage(),
    '/character_page': (context) => const CharacterPage(),
    '/dashboard_page': (context) => const DashboardPage(),
    '/todo_page': (context) => const TodoPage(),

  },

));
