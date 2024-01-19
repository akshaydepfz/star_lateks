import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:star_lateks/view/customer/screens/customer_add_screen.dart';
import 'package:star_lateks/view/customer/screens/customer_list_screen.dart';

class WeightListProvider extends ChangeNotifier {
  TextEditingController customerController = TextEditingController();

  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('weight_list');
  final TextEditingController customerNameController = TextEditingController();

  Future<void> submit(BuildContext context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CustomerListScreen()));
  }
}
