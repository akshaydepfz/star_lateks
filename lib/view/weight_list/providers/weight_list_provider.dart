import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:star_lateks/view/customer/screens/customer_list_screen.dart';
import 'package:star_lateks/view/customer/services/customer_provider.dart';

class WeightListProvider extends ChangeNotifier {
  TextEditingController customerController = TextEditingController();

  List<CustomerModel> _customerList = [];
  List<CustomerModel> get customerList => _customerList;

  final CollectionReference _customerReference =
      FirebaseFirestore.instance.collection('customers');
  final TextEditingController customerNameController = TextEditingController();

  Future<void> submit(BuildContext context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CustomerListScreen()));
  }

  Future<void> getCustomerList() async {
    final QuerySnapshot querySnapshot = await _customerReference.get();

    _customerList = querySnapshot.docs
        .map((e) => CustomerModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();

    notifyListeners();
  }
}
