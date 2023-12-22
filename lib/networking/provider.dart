import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionsProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  final transactionsCollection =
      FirebaseFirestore.instance.collection('transactions');
  return transactionsCollection.snapshots().map((snapshot) {
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  });
});
