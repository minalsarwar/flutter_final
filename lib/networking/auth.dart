// // import 'package:firebase_auth/firebase_auth.dart';

// // class AuthService {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;

// //   Future<User?> signInWithEmailAndPassword(
// //       String email, String password) async {
// //     try {
// //       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
// //         email: email,
// //         password: password,
// //       );
// //       User? user = userCredential.user;
// //       return user;
// //     } catch (e) {
// //       print('Error signing in: $e');
// //       return null;
// //     }
// //   }
// // }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<bool> signInWithEmailAndPassword(String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user != null;
//     } catch (e) {
//       print('Error signing in: $e');
//       return false;
//     }
//   }
// }

// // Optional: You can add a provider for AuthService if you want to use it with Riverpod.
// final authService = Provider<AuthService>((ref) => AuthService());

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }
}

// Optional: You can add a provider for AuthService if you want to use it with Riverpod.
final authService = Provider<AuthService>((ref) => AuthService());
