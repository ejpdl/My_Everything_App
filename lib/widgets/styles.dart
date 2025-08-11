import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class AppColors {

  static const background = Color(0xFFF6F5F2);
  static const primary = Color(0xFFE09CAA);
  static const heading = Color(0xFF455A64);
  static const subheading = Color(0xFFBA68C8);
  static const drawerbackground = Color(0xFFA75DB4);
  static const defaultcolor = Color(0xFFEEECE8);

}

class AppTextStyles {

  static const heading = TextStyle(

    color: AppColors.heading,
    fontFamily: 'Montserrat',
    fontSize: 20,
    fontWeight: FontWeight.w700,

  );

  static const subheading = TextStyle(

    color: AppColors.primary,
    fontFamily: 'Inter',
    fontSize: 15,
    fontWeight: FontWeight.w400,

  );

  static const landingPageHeading = TextStyle(

    color: AppColors.heading,
    fontFamily: 'Montserrat',
    fontSize: 25,
    fontWeight: FontWeight.w700,

  );

  static const landingPageTitle = TextStyle(

    color: AppColors.heading,
    fontFamily: 'Montserrat',
    fontSize: 15,
    fontWeight: FontWeight.w700,

  );

  static const characterPageTitle = TextStyle(

    color: AppColors.heading,
    fontFamily: 'Montserrat',
    fontSize: 20,
    fontWeight: FontWeight.w700,

  );

  static const drawerTitle = TextStyle(

    color: AppColors.defaultcolor,
    fontFamily: 'Montserrat',
    fontSize: 25,
    fontWeight: FontWeight.w700,

  );

  static const appBarTitles = TextStyle(

    color: AppColors.heading,
    fontFamily: 'Poppins',
    fontSize: 30,
    fontWeight: FontWeight.w700,

  );

  static const dialogTitle = TextStyle(

    color: AppColors.defaultcolor,
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.w700,

  );

  static const dialogTitle2 = TextStyle(

    color: AppColors.defaultcolor,
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w600,

  );



}


class Carousel extends StatelessWidget {

  final List<String> images;
  final int currentIndex;
  final VoidCallback onPrev;
  final VoidCallback onNext;

const Carousel({ super.key, 

  required this.images,
  required this.currentIndex,
  required this.onPrev,
  required this.onNext,

});

  @override
  Widget build(BuildContext context){
    return Column(

      children: [

        Row(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            
            IconButton(icon: const Icon(Icons.chevron_left, size: 40), onPressed: onPrev),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              child: Container(
                key: ValueKey<String>(images[currentIndex]),
                width: 223.0,
                height: 223.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(images[currentIndex]),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            IconButton(icon: const Icon(Icons.chevron_right, size: 40), onPressed: onNext),
          ],
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(images.length, (index) {
            final isActive = currentIndex == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: isActive ? 12.0 : 8.0,
              height: isActive ? 12.0 : 8.0,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFFE09CAA) : Colors.grey[400],
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ],
    );
  }
}


Widget custom_Header(String title, String subtitle){

  return RichText(
    text: TextSpan(
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 30.0,
        fontWeight: FontWeight.w700,
      ),
      children: [
        TextSpan(
          text: title,
          style: TextStyle(color: AppColors.heading),
        ),
        TextSpan(
          text: subtitle,
          style: TextStyle(color: AppColors.subheading),
        ),
      ],
    ),
  );

}


class GestureDetectorCards extends StatelessWidget {
  final IconData icon;
  final String imagePath;
  final String title;
  final String heroTag;
  final Widget destinationPage;
  final Color backgroundColor;
  final TextStyle? customTextStyle;

  const GestureDetectorCards({
    super.key,
    required this.icon,
    required this.imagePath,
    required this.title,
    required this.heroTag,
    required this.destinationPage,
    required this.backgroundColor,
    this.customTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 1000),
            pageBuilder: (_, __, ___) => destinationPage,
          ),
        );
      },
      child: Container(
        width: 133.0,
        height: 129.0,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 7.0,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.checklist_rounded,
                color: Colors.black,
                size: 14.0,
              ),
            ),
            Hero(
              tag: heroTag,
              child: Image.asset(
                imagePath,
                width: 76.0,
                height: 59.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 05.0),
            Text(
              title,
              style: customTextStyle ?? 
              const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget custom_DueDate(){

  return Padding(

    padding: EdgeInsets.symmetric(vertical: 20.0),

    child: Row(

      children: [

        Expanded(

          child: Row(

            children: [
              CircleAvatar(
                radius: 4.0,
                backgroundColor: Colors.white,
              ),
              Expanded(
                child: Divider(
                  color: Colors.white,
                  thickness: 1.0,
                ),
              ),
            ],
          ),

        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),

          child: Text(
            "Due Date",
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 20.0,
              letterSpacing: 1.0,
            ),
          ),
        ),

        Expanded(
          child: Row(

            children: [
              
              Expanded(
                child: Divider(
                  color: Colors.white,
                  thickness: 1.0,
                ),
              ),

              CircleAvatar(
                radius: 4.0,
                backgroundColor: Colors.white,
              ),

            ],
          ),
        ),

      ],

    ),

  );

}

