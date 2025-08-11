import 'package:flutter/material.dart';

import '../widgets/styles.dart';
import '../widgets/customTextFields.dart';
import '../widgets/customButtons.dart';

import '../services/auth_services.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({ Key? key }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _register() async {

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required.")),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match.")),
      );
      return;
    }

    final result = await AuthService.register(username, password);

    if (result == "Registration Successful"){

      Navigator.pushNamed(context, '/character_page');

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

                  child: Text("Come and Join Us!", style: AppTextStyles.landingPageHeading),

                ),

                const SizedBox(height: 20.0),

                Image.asset(
                  'assets/images/Team-spirit-pana.png',
                  width: 200.0,
                  height: 200.0,
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

                const SizedBox(height: 30.0),

                CustomTextFields(
                  label: "Confirm Password",
                  controller: _confirmPasswordController,
                  isPassword: true,
                  obscureText: _obscureConfirmPassword,
                  togglePassword: () {

                    setState(() {

                      _obscureConfirmPassword = !_obscureConfirmPassword;

                    });

                  }
                ),

                const SizedBox(height: 50.0),

                CustomButtons(
                  text: "I'm In!",
                  color: Color(0xFFF6F5F2),
                  onPressed: _register,
                  
                ),

              ],

            ),

          ),

        ),  

      ),
      
    );
  }
}