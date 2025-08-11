import 'package:flutter/material.dart';

import '../widgets/styles.dart';
import '../widgets/customTextFields.dart';
import '../widgets/customButtons.dart';

import '../services/auth_services.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({ Key? key }) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  Future<void> _login() async {

    final user = _usernameController.text.trim();
    final pass = _passwordController.text.trim();
    

    if(user.isEmpty || pass.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username and Password required")),
      );
      return;
    }

    final result = await AuthService.login(user, pass);

    print("Login Result: $result");

    if(result ==  "Login Successful"){

      Navigator.pushNamed(context, '/dashboard_page');
      print("Register button pressed");

    }else{

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result ?? 'Error')),
      );

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.background,

      body: SingleChildScrollView(

        child: Center(

          child: Padding(

            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 70.0),

            child: Column(

              children: [

                Align(

                  alignment: Alignment.centerLeft,

                  child: Text("Hi, Welcome Back!", style: AppTextStyles.landingPageHeading),

                ),

                const SizedBox(height: 20.0),

                Image.asset(
                  'assets/images/Tablet-login-rafiki.png',
                  width: 317.0,
                  height: 317.0,
                  fit: BoxFit.contain,
                ),
                
                const SizedBox(height: 20.0),

                CustomTextFields(
                  label: "Username",
                  controller: _usernameController,
                ),

                const SizedBox(height: 30.0),

                CustomTextFields(
                  label: "Password",
                  controller: _passwordController,
                  isPassword: true,
                  obscureText: _obscurePassword,
                  togglePassword: () {

                    setState(() {

                      _obscurePassword = !_obscurePassword;

                    });

                  }
                ),

                const SizedBox(height: 50.0),

                CustomButtons(
                  text: "Log In",
                  color: Color(0xFFF6F5F2),
                  onPressed: 
                  // () {Navigator.pushNamed(context, '/dashboard_page');},
                  _login,
                ),

              ],

            ),

          ),

        ),  

      ),
      
    );
  }
}