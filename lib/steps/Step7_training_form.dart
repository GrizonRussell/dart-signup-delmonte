import 'package:flutter/material.dart';

class TrainingForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, String> formData;

  TrainingForm({required this.formKey, required this.formData});

  @override
  _TrainingFormState createState() => _TrainingFormState();
}

class _TrainingFormState extends State<TrainingForm> {
  final TextEditingController _trainingController = TextEditingController();

  @override
  void dispose() {
    _trainingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: <Widget>[
          _buildTextField(
            'Training',
            'training',
            widget.formData,
            controller: _trainingController,
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

  Widget _buildTextField(
    String label,
    String key,
    Map<String, String> formData, {
    required TextEditingController controller,
    FormFieldValidator<String>? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
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
        validator: validator,
        onSaved: (value) {
          formData[key] = value ?? '';
        },
      ),
    );
  }
}
