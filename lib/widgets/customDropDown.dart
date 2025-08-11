import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {

  final String label;
  final String? value;
  final List<String> options;
  final TextStyle? customValueStyle;
  final TextStyle? customTextStyle;
  final void Function(String?) onChanged;

  const CustomDropdown({

    Key? key,
    required this.label,
    required this.value,
    required this.options,
    this.customValueStyle,
    this.customTextStyle,
    required this.onChanged,

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Text(
          label,
          style: customTextStyle ?? const TextStyle(
            color: Color(0xFF455A64),
            fontFamily: 'Montserrat',
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 10.0),

        DropdownButtonFormField<String>(
          value: value,
          style: customValueStyle ?? const TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color(0xFFE09CAA),
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color(0xFFE09CAA),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color.fromRGBO(192, 50, 78, 1),
                width: 2.0,
              ),
            ),
          ),

          hint: Center(
            child: Text(
              "Select $label",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF455A64),
                fontFamily: 'Montserrat',
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF455A64),
          ),

          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),

        ),
      ],
    );
  }
}