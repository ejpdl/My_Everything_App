import 'package:flutter/material.dart';

import '../widgets/styles.dart';

class LandingPage extends StatelessWidget {
const LandingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(

       backgroundColor: Color(0xFFF6F5F2),

      body: Center(

        child: Padding(

          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 50.0),

          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,

            children: [

              Image.asset(
                'assets/images/Connected-world-amico.png',
                width: 350.0,
                height: 350.0,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 20.0),

              const Text(
                "Organized Your Life",
                style: AppTextStyles.heading,
              ),

              const SizedBox(height: 10.0),

              const Text(
                "Stay productive, stay organized, and take control of your everyday life all in one app.",
                textAlign: TextAlign.center,
                style: AppTextStyles.subheading,
              ),

              const SizedBox(height: 150.0),

              SizedBox(

                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login_page');
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 7.0,
                    backgroundColor: Color(0xFFBA68C8),
                    minimumSize: Size(348.0, 56.0),
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      color: Color(0xFFF6F5F2),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),

                  ),
                ),

              ),

              const SizedBox(height: 30.0),

              SizedBox(

                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register_page');
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(348.0, 56.0),
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),               
                    ),
                    side: BorderSide(
                      color: Color(0xFFE09CAA),
                      width: 1.5,
                    ), 
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: Color(0xFFE09CAA),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),

            ],

          ),

        ),

      ),

    );
  }
}