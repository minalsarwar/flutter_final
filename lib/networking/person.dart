import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  final String name;
  final int age;
  final String profession;

  Person({
    required this.name,
    required this.age,
    required this.profession,
  });

  // Add a method to convert the object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'profession': profession,
    };
  }
}

class AddPersonScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController professionController = TextEditingController();

  AddPersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Person'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: professionController,
              decoration: InputDecoration(labelText: 'Profession'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _submitForm(context),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) async {
    final String name = nameController.text.trim();
    final int age = int.tryParse(ageController.text) ?? 0;
    final String profession = professionController.text.trim();

    if (name.isNotEmpty && age > 0 && profession.isNotEmpty) {
      // Create a Person object
      final Person person =
          Person(name: name, age: age, profession: profession);

      // Add the data to Firestore
      await FirebaseFirestore.instance.collection('people').add(person.toMap());

      // Clear the form fields
      nameController.clear();
      ageController.clear();
      professionController.clear();

      // Show a success message or navigate to a different screen
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Person added to Firestore!'),
      ));
    } else {
      // Show an error message if the form is not filled out correctly
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill out all fields correctly.'),
        backgroundColor: Colors.red,
      ));
    }
  }
}
