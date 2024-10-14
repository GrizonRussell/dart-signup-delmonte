import 'package:flutter/material.dart';

class SkillsForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, String> formData;

  SkillsForm({required this.formKey, required this.formData});

  @override
  _SkillsFormState createState() => _SkillsFormState();
}

class _SkillsFormState extends State<SkillsForm> {
  final TextEditingController _skillsController = TextEditingController();

  @override
  void dispose() {
    _skillsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: <Widget>[
          _buildTextField(
            'Skills',
            'skills',
            widget.formData,
            controller: _skillsController,
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
                color: const Color.fromRGBO(11, 134, 74, 1).withOpacity(0.5)),
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




// import 'package:flutter/material.dart';
// import 'dart:convert';

// class SkillsForm extends StatefulWidget {
//   final GlobalKey<FormState> formKey;
//   final Map<String, String> formData;
//   final List<Map<String, dynamic>> skillList;

//   SkillsForm({
//     required this.formKey,
//     required this.formData,
//     required this.skillList,
//   });

//   @override
//   _SkillsFormState createState() => _SkillsFormState();
// }

// class _SkillsFormState extends State<SkillsForm> {
//   List<dynamic> skillData = [];
//   int? indexToRemove;
//   String alertMessage = '';
//   bool showAlert = false;

//   final TextEditingController _skillController = TextEditingController();

//   @override
//   void dispose() {
//     _skillController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loadSkills();
//   }

//   Future<void> _loadSkills() async {
//     // Replace this with your retrieval logic
//     String? skills = await retrieveData('skills');
//     if (skills != null && skills != '[]') {
//       setState(() {
//         skillData = jsonDecode(skills);
//       });
//     }
//   }

//   void _handleShowAlert(String message) {
//     setState(() {
//       alertMessage = message;
//       showAlert = true;
//     });
//   }

//   void _handleCloseAlert(int status) {
//     if (status == 1) {
//       setState(() {
//         skillData.removeAt(indexToRemove!);
//       });
//       storeData('skills', jsonEncode(skillData));
//     }
//     setState(() {
//       showAlert = false;
//     });
//   }

//   void _handleRemoveList(int index) {
//     setState(() {
//       indexToRemove = index;
//     });
//     _handleShowAlert(
//         'This action cannot be undone. It will permanently delete the item and remove it from your list.');
//   }

//   void _addSkill(String newSkill) {
//     setState(() {
//       skillData.add({'skills': newSkill});
//     });
//     storeData('skills', jsonEncode(skillData));
//   }

//   void _showAddSkillModal(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Add Skill'),
//           content: SkillsInputForm(
//             formKey: widget.formKey,
//             formData: widget.formData,
//             skillController: _skillController, // Pass the skillController
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 if (widget.formKey.currentState!.validate()) {
//                   widget.formKey.currentState!.save();
//                   _addSkill(widget.formData['skill'] ?? '');
//                   Navigator.of(context).pop();
//                 }
//               },
//               child: Text('Add'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Skills'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton.icon(
//             icon: Icon(Icons.add),
//             label: Text('Add Skills'),
//             onPressed: () => _showAddSkillModal(context),
//           ),
//           Expanded(
//             child: skillData.isNotEmpty
//                 ? ListView.builder(
//                     itemCount: skillData.length,
//                     itemBuilder: (context, index) {
//                       return Card(
//                         color: Colors.green.shade700,
//                         child: ListTile(
//                           title: Text(
//                             widget.skillList.firstWhere((item) =>
//                                     item['value'] ==
//                                     skillData[index]['skills'])['label'] ??
//                                 'Unknown Skill',
//                           ),
//                           trailing: IconButton(
//                             icon: Icon(Icons.delete, color: Colors.white),
//                             onPressed: () => _handleRemoveList(index),
//                           ),
//                         ),
//                       );
//                     },
//                   )
//                 : Center(child: Text('No skills added yet')),
//           ),
//           if (showAlert)
//             AlertDialog(
//               title: Text('Delete Confirmation'),
//               content: Text(alertMessage),
//               actions: [
//                 ElevatedButton(
//                   onPressed: () {
//                     _handleCloseAlert(1);
//                   },
//                   child: Text('Delete'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     _handleCloseAlert(0);
//                   },
//                   child: Text('Cancel'),
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
// }

// class SkillsInputForm extends StatelessWidget {
//   final GlobalKey<FormState> formKey;
//   final Map<String, String> formData;
//   final TextEditingController skillController;

//   SkillsInputForm({
//     required this.formKey,
//     required this.formData,
//     required this.skillController,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formKey,
//       child: Column(
//         children: <Widget>[
//           _buildTextField(
//             'Skill',
//             'skill',
//             formData,
//             controller: skillController,
//             validator: (value) {
//               return value == null || value.isEmpty
//                   ? 'This field is required'
//                   : null;
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField(
//     String label,
//     String key,
//     Map<String, String> formData, {
//     required TextEditingController controller,
//     FormFieldValidator<String>? validator,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: const TextStyle(color: Colors.black),
//           filled: true,
//           fillColor: const Color.fromARGB(255, 25, 189, 109).withOpacity(0.2),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//                 color: const Color.fromRGBO(11, 134, 74, 1).withOpacity(0.5)),
//           ),
//           focusedBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: Color.fromRGBO(11, 134, 74, 1)),
//           ),
//         ),
//         validator: validator,
//         onSaved: (value) {
//           formData[key] = value ?? '';
//         },
//       ),
//     );
//   }
// }

// // Mock function for storage utilities (similar to your utils/storageUtils in React)
// Future<void> storeData(String key, String value) async {
//   // Logic to store data
// }

// Future<String?> retrieveData(String key) async {
//   // Logic to retrieve data
//   return null; // Replace with actual retrieval logic
// }
