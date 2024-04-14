import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransactionProvider extends ChangeNotifier {
  Future<void> getTransactions() async {}

  Future<void> addTransaction() async {
    await FirebaseFirestore.instance.collection('transactions').doc().set({
      'title': 'Paid Salary',
      'subtitle': '12000 payed to Akshay',
      'date': DateTime.now(),
      'id': "",
      "type": "",
    });
  }

  Future<void> updateTransaction() async {}

  Future<void> deleteTransaction() async {}
}
