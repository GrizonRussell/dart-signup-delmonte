import 'package:flutter/material.dart';

class SubscribeToEmailForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, dynamic> formData;

  SubscribeToEmailForm({required this.formKey, required this.formData});

  @override
  _SubscribeToEmailFormState createState() => _SubscribeToEmailFormState();
}

class _SubscribeToEmailFormState extends State<SubscribeToEmailForm> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.formData['isSubscribeToEmail'] == 1;
  }

  void handleCheckboxChange(bool? value) {
    if (value != null) {
      setState(() {
        isChecked = value;
        widget.formData['isSubscribeToEmail'] = isChecked ? 1 : 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: handleCheckboxChange,
                activeColor: Colors.white,
                checkColor: const Color(0xFF0E4028),
              ),
              Expanded(
                child: Text(
                  'Agree (optional)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
