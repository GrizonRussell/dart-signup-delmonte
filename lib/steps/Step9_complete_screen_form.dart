import 'package:flutter/material.dart';

class StepsCompleteScreenForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, dynamic> formData;

  StepsCompleteScreenForm({required this.formKey, required this.formData});

  @override
  _StepsCompleteScreenFormState createState() =>
      _StepsCompleteScreenFormState();
}

class _StepsCompleteScreenFormState extends State<StepsCompleteScreenForm> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked =
        widget.formData['isStepComplete'] == 1; // Initialize checkbox state
  }

  void handleCheckboxChange(bool? value) {
    if (value != null) {
      setState(() {
        isChecked = value;
        widget.formData['isStepComplete'] =
            isChecked ? 1 : 0; // Update form data
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Text(
              'Yey',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8), // Space between the text and checkbox
            Checkbox(
              value: isChecked,
              onChanged: handleCheckboxChange,
              activeColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
