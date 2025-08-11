import 'package:flutter/material.dart';

import '../widgets/styles.dart';
import '../widgets/customTextFields.dart';
import '../widgets/customDropDown.dart';

import '../services/auth_services.dart';

class CustomDialog extends StatefulWidget {

  final String title;
  
  const CustomDialog({ super.key, required this.title });

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? selectedMonth;
  String? selectedDay;

  final List<String> MonthOptions = ["JAN.", "FEB.", "MAR.", "APR.", "MAY.", "JUN.", "JUL.", "AUG.", "SEP.", "OCT.", "NOV.", "DEC."];

  final List<String> DayOptions = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"];

  Future<void> _submitTodo() async {

    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty || selectedMonth == null || selectedDay == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required')),
      );
      return;
    }

    final result = await AuthService.createTodo(

      title: title,
      description: description,
      month: selectedMonth!,
      day: selectedDay!

    );

    if (result == "To-Do Created") {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('To-Do Added Successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Center(

      child: SingleChildScrollView(

        child: Dialog(

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          backgroundColor: Colors.transparent,

          child: Container(

            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFF2A303E),
              borderRadius: BorderRadius.circular(10.0),
            ),

            child: Column(

              mainAxisSize: MainAxisSize.min,

              children: [

                const SizedBox(height: 20.0),

                Text(
                  widget.title,
                  style: AppTextStyles.dialogTitle,
                ),

                const SizedBox(height: 20.0),

                CustomTextFields(
                
                  label: "Title", 
                  labelColor: Colors.white,
                  inputColor: Colors.white, 
                  controller: _titleController
                
                ),

                const SizedBox(height: 30.0),

                CustomTextFields(
                
                  label: "Description", 
                  labelColor: Colors.white,
                  inputColor: Colors.white, 
                  controller: _descriptionController
                
                ),

                const SizedBox(height: 10.0),

                custom_DueDate(),

                const SizedBox(height: 10.0),

                Row(

                  children: [

                    Container(

                      width: 139.0,
                      child: CustomDropdown(
                        label: "Month",
                        value: selectedMonth,
                        customValueStyle: TextStyle(
                          color: Color.fromRGBO(192, 50, 78, 1),
                          fontFamily: 'Poppins',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                        ),
                        options: MonthOptions,
                        customTextStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                        onChanged: (val) => setState(() => selectedMonth = val),
                      ),

                    ),
                    
                    const SizedBox(width: 12.0),

                    Container(

                      width: 120.0,
                      child: CustomDropdown(
                        label: "Day",
                        value: selectedDay,
                        customValueStyle: TextStyle(
                          color: Color.fromRGBO(192, 50, 78, 1),
                          fontFamily: 'Poppins',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                        ),
                        options: DayOptions,
                        customTextStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                        onChanged: (val) => setState(() => selectedDay = val),
                      ),

                    ),

                  ],

                ),

                const SizedBox(height: 50.0),

                Row(

                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: [

                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(116.0, 43.0),
                        padding: EdgeInsets.all(15.0),
                        side: BorderSide(
                          color: Color(0xFFA75DB4),
                          width: 1.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Color(0xFFF6F5F2),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 15.0,
                        ),

                      ),
                    ),

                    ElevatedButton(
                      onPressed: _submitTodo,
                      style: ElevatedButton.styleFrom(
                        elevation: 7.0,
                        backgroundColor: Color(0xFF8D2162),
                        minimumSize: Size(116.0, 43.0),
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        "Add",
                        style: TextStyle(
                          color: Color(0xFFF6F5F2),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 15.0,
                        ),

                      ),
                    ),

                  ],

                ),

                const SizedBox(height: 10.0),

              ],

            ),

          ),

        ),

      ),

    );
  }
}

class DeleteDialog extends StatelessWidget {

  final int todoId;
  final VoidCallback onDeleted;

  const DeleteDialog({ 

    Key? key,
    required this.todoId,
    required this.onDeleted 

  }) : super(key: key);

  Future<void> _delete(BuildContext context) async {

    final result = await AuthService.deleteTodo(todoId);

    if(result == "To-Do Deleted"){
      Navigator.pop(context);
      onDeleted();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task deleted successfully')),
      );
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Center(

      child: SingleChildScrollView(

        child: Dialog(

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          backgroundColor: Color(0xFF8D2162),

          child: Container(

            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFF2A303E),
              borderRadius: BorderRadius.circular(10.0),
            ),

            child: Column(

              mainAxisSize: MainAxisSize.min,

              children: [

                const SizedBox(height: 20.0),

                Text(
                  "Delete this Task?",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 10.0),

                Text(
                  "Once you delete this, it will not be undone",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontFamily: 'Poppins',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 20.0),

                Row(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [

                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(116.0, 43.0),
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        side: BorderSide(
                          color: Color(0xFFA75DB4),
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    const SizedBox(width: 05.0),

                    ElevatedButton(
                      onPressed: () => _delete(context),
                      style: ElevatedButton.styleFrom(
                        elevation: 7.0,
                        backgroundColor: Color(0xFFA71111),
                        minimumSize: Size(116.0, 43.0),
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      ),
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),

                  ],

                ),

                const SizedBox(height: 10.0),

              ],

            ),

          ),

        ),

      ),
      
    );
  }
}