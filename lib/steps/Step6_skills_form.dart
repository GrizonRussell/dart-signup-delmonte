import 'package:flutter/material.dart';

class SkillsForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, String> formData;

  SkillsForm({required this.formKey, required this.formData});

  @override
  _SkillsFormState createState() => _SkillsFormState();
}

class _SkillsFormState extends State<SkillsForm> {
  String? _selectedSkill;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: <Widget>[
          _buildDropdownField(
            'Skills',
            'skills',
            widget.formData,
            validator: (value) {
              return value == null || value.isEmpty
                  ? 'This field is required'
                  : null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    String key,
    Map<String, String> formData, {
    FormFieldValidator<String>? validator,
  }) {
    // List of skills for the dropdown
    final List<String> skills = [
      'Flutter',
      'Dart',
      'Java',
      'JavaScript',
      'Python',
      'C++',
      'HTML/CSS',
      // Add more skills as needed
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: _selectedSkill,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: const Color.fromARGB(255, 25, 189, 109)
              .withOpacity(0.2), // Set fill color to green
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
        dropdownColor: const Color.fromRGBO(11, 134, 74, 1),
        items: skills.map((String skill) {
          return DropdownMenuItem<String>(
            value: skill,
            child: Text(skill),
          );
        }).toList(),
        validator: validator,
        onChanged: (value) {
          setState(() {
            _selectedSkill = value;
            formData[key] = value ?? ''; // Save selected skill to formData
          });
        },
      ),
    );
  }
}
