import 'package:flutter/material.dart';

import '../widgets/styles.dart';
import '../widgets/customButtons.dart';

class GetStartedPage extends StatelessWidget {
const GetStartedPage({ super.key });

  @override
  Widget build(BuildContext context){

    return Scaffold(

      backgroundColor: AppColors.background,

      body: Center(

        child: Padding(

          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 50.0),

          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,

            children: [

              Image.asset(
                'assets/images/LandingPage.png',
                width: 388.0,
                height: 388.0,
                fit: BoxFit.cover,
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

              const SizedBox(height: 200.0),

              CustomButtons(
                text: "Get Started",
                color: Color(0xFFF6F5F2),
                onPressed: () {

                  Navigator.pushNamed(context, '/landing_page');

                }
              ),

            ],

          ),

        ),

      ), 

    );
  }
}