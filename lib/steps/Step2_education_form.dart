// lib/steps/education_form.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EducationForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, String> formData;
  final List<Map<String, String>> institutionList;
  final List<Map<String, String>> courseList;

  EducationForm({
    required this.formKey,
    required this.formData,
    required this.institutionList,
    required this.courseList,
  });

  @override
  _EducationFormState createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {
  String? selectedInstitution;
  String? selectedCourse;
  DateTime? selectedGraduationDate;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Institution Dropdown
          _buildDropdownField(
            label: 'Institution',
            items: widget.institutionList,
            value: selectedInstitution,
            onChanged: (value) {
              setState(() {
                selectedInstitution = value;
                widget.formData['institution'] = value!;
              });
            },
          ),

          // Course Dropdown (dependent on Institution)
          _buildDropdownField(
            label: 'Course',
            items: widget.courseList
                .where((item) => item['institution'] == selectedInstitution)
                .toList(),
            value: selectedCourse,
            onChanged: (value) {
              setState(() {
                selectedCourse = value;
                widget.formData['course'] = value!;
              });
            },
          ),

          // Date Graduated (with Calendar Picker)
          _buildDatePickerField(
            label: 'Date Graduated',
            selectedDate: selectedGraduationDate,
            onDateSelected: (date) {
              setState(() {
                selectedGraduationDate = date;
                widget.formData['graduationDate'] =
                    DateFormat('yyyy-MM-dd').format(date);
              });
            },
          ),
        ],
      ),
    );
  }

  // Helper method for Dropdown Field
  Widget _buildDropdownField({
    required String label,
    required List<Map<String, String>> items,
    String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
          filled: true,
          fillColor: const Color.fromARGB(255, 25, 189, 109).withOpacity(0.2),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color.fromRGBO(11, 134, 74, 1).withOpacity(0.5),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(11, 134, 74, 1)),
          ),
        ),
        style: const TextStyle(color: Colors.white),
        value: value,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item['value'],
            child: Text(item['label']!),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) {
          return value == null || value.isEmpty
              ? 'This field is required'
              : null;
        },
      ),
    );
  }

  // Helper method for Date Picker Field
  Widget _buildDatePickerField({
    required String label,
    DateTime? selectedDate,
    required ValueChanged<DateTime> onDateSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
          filled: true,
          fillColor: const Color.fromARGB(255, 25, 189, 109).withOpacity(0.2),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color.fromRGBO(11, 134, 74, 1).withOpacity(0.5),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(11, 134, 74, 1)),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.white),
            onPressed: () => _selectDate(context, onDateSelected),
          ),
        ),
        style: const TextStyle(color: Colors.white),
        controller: TextEditingController(
          text: selectedDate == null
              ? 'Select a date'
              : DateFormat('MMMM dd, yyyy').format(selectedDate),
        ),
        validator: (value) {
          return value == null || value.isEmpty
              ? 'This field is required'
              : null;
        },
      ),
    );
  }

  // Method to show Date Picker
  Future<void> _selectDate(
      BuildContext context, ValueChanged<DateTime> onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedGraduationDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedGraduationDate) {
      onDateSelected(picked);
    }
  }
}
