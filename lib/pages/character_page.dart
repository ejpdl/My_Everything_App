import 'package:flutter/material.dart';

import '../services/character_service.dart';

import '../widgets/customDropDown.dart';
import '../widgets/customButtons.dart';
import '../widgets/customTextFields.dart';
import '../widgets/styles.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({ Key? key }) : super(key: key);

  @override
  _CharacterPageState createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {

  String? selectedCourse;

  int currentIndex = 0;

  final TextEditingController _FirstNameController = TextEditingController(); 

   final List<String> imagePaths = [

    'assets/images/messy-bun-bro.png',
    'assets/images/messy-bun-amico.png',
    'assets/images/messy-bun-cuate.png',
    'assets/images/messy-bun-pana.png',
    'assets/images/messy-bun-rafiki.png',

  ];

  final List<String> courseOptions = [

    'Bachelor of Science in Computer Science',
    'Bachelor of Science in Computer Engineering',
    'Bachelor of Science in Accountacy',
    'Bachelor of Science in Business Administration',
    'Bachelor of Basic Education',
    'Bachelor of Secondary Education',
    'Bachelor of Science in Nursing',
    'International Tourism'

  ];

  void _previousImage() => setState(() => currentIndex = (currentIndex - 1 + imagePaths.length) % imagePaths.length);

  void _nextImage() => setState(() => currentIndex = (currentIndex + 1) % imagePaths.length);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.background,

      body: SingleChildScrollView(

        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 30.0),

            const Text(
              "Ready, Get Set, Go With Me!",
              style: AppTextStyles.characterPageTitle,
            ),

            const SizedBox(height: 20.0),

            Carousel(
              images: imagePaths,
              currentIndex: currentIndex,
              onPrev: _previousImage,
              onNext: _nextImage,
            ),

            const SizedBox(height: 50.0),

            CustomTextFields(
              label: "First Name",
              controller: _FirstNameController,
            ),

            const SizedBox(height: 30.0),

            Row(

              children: [
                
                Expanded(
                  child: CustomDropdown(
                    label: "Course",
                    value: selectedCourse,
                    options: courseOptions,
                    onChanged: (val) => setState(() => selectedCourse = val),
                  ),
                ),

              ],

            ),

            const SizedBox(height: 60.0),

            CustomButtons(
              text: "Let's Go!",
              color: Color(0xFFF6F5F2),
              onPressed: () async {

                final firstName = _FirstNameController.text.trim();

                if(firstName.isEmpty || selectedCourse == null) {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("All fields are required.")),
                  );
                  return;
                }

                final result = await CharacterService.saveCharacter(
                  
                  image: imagePaths[currentIndex],
                  firstName: firstName,
                  course: selectedCourse!,

                );

                print("Character Save Result: $result");

                if (result == "Character saved successfully") {
                  Navigator.pushNamed(context, '/dashboard_page');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result ?? "Unknown error")),
                  );
                }

              },
            ),
            
          ],
        ),
      ),
      
    );
  }
}

