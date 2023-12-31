import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/networking/dashboard.dart';
import 'package:flutter_final/networking/model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_final/networking/auth.dart';

// final petsProvider = StreamProvider<List<Pet>>((ref) async* {
//   final snapshots = FirebaseFirestore.instance.collection('1').snapshots();
//   await for (final snapshot in snapshots) {
//     yield snapshot.docs.map((doc) => Pet.fromFirestore(doc)).toList();
//   }
// });

final authProvider = StateProvider<User?>((ref) {
  return null;
});

final isPasswordVisibleProvider = StateProvider<bool>((ref) {
  return false;
});

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final emailControllerProvider = Provider<TextEditingController>((ref) =>
    TextEditingController()); //credentials widget recreation mai clear na hon
final passwordControllerProvider =
    Provider<TextEditingController>((ref) => TextEditingController());

final friendsProvider = StreamProvider<List<Friend>>((ref) {
  // Your logic to create a stream of friends from Firebase or another source
  final friendsCollection = FirebaseFirestore.instance.collection('friends');
  return friendsCollection.snapshots().map((snapshot) {
    return snapshot.docs
        .map((doc) => Friend(
              name: doc['name'],
              email: doc['email'],
              phone: doc['phone'],
              image: doc['image'],
            ))
        .toList();
  });
});

// final isListViewProvider = StateProvider<bool>((ref) {
//   return false; // Set the initial value based on your default view
// });

final selectedViewIndexProvider = StateProvider<int>((ref) => 0);

final currentIndexProvider = StateProvider<int>((ref) {
  return 0; // Initial index, set to the default tab you want to be selected.
});
