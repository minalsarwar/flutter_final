// // import 'dart:math';

// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';

// // class Pet {
// //   final String name;
// //   final String colour;
// //   final String age;
// //   final String image;

// //   Pet({
// //     required this.name,
// //     required this.colour,
// //     required this.age,
// //     required this.image,
// //   });

// //   factory Pet.fromFirestore(DocumentSnapshot doc) {
// //     Map data = doc.data() as Map<String, dynamic>;
// //     return Pet(
// //       name: data['name'] ?? '',
// //       colour: data['colour'] ?? '',
// //       age: data['age'] ?? '',
// //       image: data['image'] ?? '',
// //     );
// //   }
// // }

// // class PetsPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Pets List'),
// //         backgroundColor: Colors.amber[300],
// //       ),
// //       body: StreamBuilder<QuerySnapshot>(
// //         stream: FirebaseFirestore.instance.collection('1').snapshots(),
// //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return CircularProgressIndicator();
// //           } else if (snapshot.hasError) {
// //             return Text('Error: ${snapshot.error}');
// //           }

// //           List<Pet> pets = [];
// //           snapshot.data!.docs.forEach((doc) {
// //             pets.add(Pet.fromFirestore(doc));
// //           });

// //           return ListView.builder(
// //             itemCount: pets.length,
// //             itemBuilder: (context, index) {
// //               return _buildPetCard(pets[index]);
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   Widget _buildPetCard(Pet pet) {
// //     final List<Color> pastelColors = [
// //       const Color.fromARGB(255, 225, 170, 188)!,
// //       const Color.fromARGB(255, 163, 202, 234)!,
// //       const Color.fromARGB(255, 192, 230, 193)!,
// //     ];

// //     final random = Random();
// //     final colorIndex = random.nextInt(pastelColors.length);
// //     final cardColor = pastelColors[colorIndex];

// //     return Card(
// //       color: cardColor,
// //       child: Column(
// //         children: [
// //           ListTile(
// //             title: Text(pet.name),
// //             subtitle: Text('Age: ${pet.age}, Colour: ${pet.colour}'),
// //           ),
// //           Image.network(
// //             pet.image,
// //             height: 200,
// //             width: 200,
// //             fit: BoxFit.cover,
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_final/networking/provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class Pet {
//   final String name;
//   final String colour;
//   final String age;
//   final String image;

//   Pet({
//     required this.name,
//     required this.colour,
//     required this.age,
//     required this.image,
//   });

//   factory Pet.fromFirestore(DocumentSnapshot doc) {
//     Map data = doc.data() as Map<String, dynamic>;
//     return Pet(
//       name: data['name'] ?? '',
//       colour: data['colour'] ?? '',
//       age: data['age'] ?? '',
//       image: data['image'] ?? '',
//     );
//   }
// }

// class PetsPage extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final pets = ref.watch(petsProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pets List'),
//         backgroundColor: Colors.amber[300],
//       ),
//       body: pets.when(
//         loading: () => CircularProgressIndicator(),
//         error: (error, stack) => Text('Error: $error'),
//         data: (pets) {
//           return ListView.builder(
//             itemCount: pets.length,
//             itemBuilder: (context, index) {
//               return _buildPetCard(context, pets[index]);
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildPetCard(BuildContext context, Pet pet) {
//     final List<Color> pastelColors = [
//       const Color.fromARGB(255, 225, 170, 188)!,
//       const Color.fromARGB(255, 163, 202, 234)!,
//       const Color.fromARGB(255, 192, 230, 193)!,
//     ];

//     final random = Random();
//     final colorIndex = random.nextInt(pastelColors.length);
//     final cardColor = pastelColors[colorIndex];

//     return Card(
//       color: cardColor,
//       child: Column(
//         children: [
//           ListTile(
//             title: Text(pet.name),
//             subtitle: Text('Age: ${pet.age}, Colour: ${pet.colour}'),
//           ),
//           Image.network(
//             pet.image,
//             height: 200,
//             width: 200,
//             fit: BoxFit.cover,
//           ),
//         ],
//       ),
//     );
//   }
// }
